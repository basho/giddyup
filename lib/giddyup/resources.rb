require 'stringio'
require 'json'
require 'thread'

module GiddyUp
  # When modifying a record, wraps the resource in a transaction that
  # can be rolled back if the request is not successful.
  module TransactionalResource
    # Starts a DB transaction on initialization if the resource
    # indicates it should process inside a transaction.
    def initialize
      if transactional? && db.outside_transaction?
        db.begin_db_transaction
      end
    end

    # Rolls back the DB transaction if the response code is not an
    # error (that is, if it's not a 2xx or 3xx response). Otherwise,
    # commits the transaction.
    def finish_request
      if transactional? && !db.outside_transaction?
        if response.code < 400
          db.commit_db_transaction
        else
          db.rollback_db_transaction
        end
      end
      super
    end

    # Whether to open a transaction for the request. By default, true.
    def transactional?
      true
    end

    private
    def db
      ActiveRecord::Base.connection
    end
  end

  # Base class for resources
  class Resource < Webmachine::Resource
    include Webmachine::Resource::Authentication

    def encodings_provided
      { 'gzip' => :encode_gzip,
        'deflate' => :encode_deflate,
        'identity' => :encode_identity }
    end

    def is_authorized?(auth)
      return true unless %W{PUT POST DELETE}.include?(request.method)
      basic_auth(auth, "GiddyUp") do |user, pass|
        user == AUTH_USER && pass == AUTH_PASSWORD
      end
    end

    def content_types_provided
      [['application/json', :to_json]]
    end

    def finish_request
      super
      ActiveRecord::Base.connection.close
    end

    def query_ids
      return [] unless request.uri.query
      request.uri.query.split(/\&/).inject([]) do |ids, pair|
        key, value = pair.split(/\=/)
        if key && value && CGI.unescape(key) == 'ids[]'
          ids << CGI.unescape(value)
        end
        ids
      end
    end
  end

  class LiveResource < Webmachine::Resource
    def initialize
      set_headers
    end

    def set_headers
      response.headers['Connection']    ||= 'keep-alive'
      response.headers['Cache-Control'] ||= 'no-cache'
    end

    def allowed_methods
      %W[GET]
    end

    def content_types_provided
      [['text/event-stream', :to_event]]
    end

    def to_event
      # TODO: Make this more generic. We assume subscription is
      # non-blocking, which is a AS::Notifications thing. redis-rb,
      # for example, uses blocking subscriptions. We need the
      # pump/event-loop to ensure that the Fiber does not terminate
      # prematurely.
      queue = Queue.new
      subscriber = GiddyUp::Events.subscribe('events') do |_, payload|
        id = payload['id']
        event = payload['event']
        data = JSON.generate(payload['data'])
        queue << "id: #{id}\nevent: #{event}\ndata: #{data}\n\n"
      end

      Fiber.new do |f|
        begin
          loop do
            Fiber.yield queue.pop
          end
        ensure
          GiddyUp::Events.unsubscribe(subscriber)
        end
      end
    end
  end

  # Allows posting of a new test result (or fetching an existing
  # result). This should be in JSON or multipart/form-data, depending
  # on the contents of the log data and the capabilities of the
  # client. Allowing multipart/form-data specifically could support
  # manually uploading test data from a browser.
  class TestResultResource < Resource
    include TransactionalResource

    def transactional?
      request.post?
    end

    def allowed_methods
      %W[GET HEAD POST OPTIONS]
    end

    def content_types_accepted
      [["application/json", :accept_json]]
    end

    def resource_exists?
      return false unless request.path_info[:id]
      @test_result = TestResult.find(request.path_info[:id])
      @test_result.present?
    end

    def post_is_create?; true; end
    def allow_missing_post?; true; end

    def create_path
      @context = CreateTestResult.new
      URI.join(request.base_uri.to_s, "/test_results/#{@context.id}")
    end

    def to_json
      TestResultSerializer.new(@test_result).to_json
    end

    def accept_json
      begin
        data = MultiJson.load(request.body.to_s)
      rescue
        raise Webmachine::MalformedRequest, "Invalid JSON body"
      end
      @context.create_test_result(data)
    end
  end

  class ArtifactResource < Resource
    include TransactionalResource

    def allowed_methods
      if request.path_info[:id].present?
        ['GET']
      elsif request.path_info[:test_result_id].present?
        ['POST']
      else
        []
      end
    end

    def content_types_provided
      if resource_exists? == true
        [ [ "application/json", :to_json ],
          [ @artifact.content_type, :to_raw ] ]
      else
        super
      end
    end

    def content_types_accepted
      [[ request.headers['content-type'], :accept_artifact ]]
    end

    def resource_exists?
      if request.get?
        return false unless request.path_info[:id].present?
        @artifact = Artifact.find(request.path_info[:id])
        @artifact.present?
      elsif request.path_info[:test_result_id].present?
        @context = CreateArtifact.new(request.path_info[:test_result_id])
        @context.can_create? ? false : 404
      end
    end

    def allow_missing_post?; true; end
    def post_is_create?; true; end
    def create_path
      URI.join(request.base_uri.to_s, "/artifacts/#{@context.id}")
    end

    def accept_artifact
      @context.create_artifact('path' => request.path_tokens.join('/'),
                               'body' => request.body,
                               'content_type' => request.headers['content-type'])
    end

    def to_json
      ArtifactSerializer.new(@artifact).to_json
    end

    def to_raw
      # Streaming all the way down
      Fiber.new do
        Excon.get(@artifact.url,
                  :response_block => lambda {|chunk, remaining, size| Fiber.yield chunk })
        nil
      end
    end

    def transactional?
      request.put?
    end
  end

  class TestResultsResource < Resource
    def resource_exists?
      begin
        @test_results = TestResult.find(query_ids)
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      ActiveModel::ArraySerializer.new(@test_results, {:root => "test_results"}).to_json
    end
  end

  class ProjectsListResource < Resource
    def to_json
      ActiveModel::ArraySerializer.new(Project.all, {
                                         :root => "projects"
                                       }).to_json
    end
  end

  class ProjectResource < Resource
    def resource_exists?
      scope = Project.where(:name => request.path_info[:name])
      if !request.query.empty?
        query = request.query.dup
        scope = scope.includes(:tests).order('tests.name asc')
        if version = query.delete('version')
          scope = Test.for_version(version, scope)
        end
        scope = scope.where(['tests.tags::hstore @> ?', HstoreSerializer.dump(query)])
      end
      @project = scope.first
      @project.present?
    end

    def to_json
      options = request.query.empty? ? {} : {:scope => :filtered}
      ProjectSerializer.new(@project, options).to_json
    end
  end

  class ScorecardsResource < Resource
    def resource_exists?
      begin
        @scorecards = Scorecard.find(query_ids)
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      ActiveModel::ArraySerializer.new(@scorecards, {:root => "scorecards"}).to_json
    end
  end

  class ScorecardResource < Resource
    def resource_exists?
      begin
        @scorecard = Scorecard.find(request.path_info[:id])
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      ScorecardSerializer.new(@scorecard, {}).to_json
    end
  end

  class TestInstancesResource < Resource
    def resource_exists?
      begin
        @test_instances = query_ids.map do |id|
          TestInstance.find(id)
        end
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      ActiveModel::ArraySerializer.new(@test_instances, {:root => "test_instances"}).to_json
    end
  end

  class TestInstanceResource < Resource
    def resource_exists?
      begin
        @test_instance = TestInstance.find(request.path_info[:id])
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      TestInstanceSerializer.new(@test_instance, :root => "test_instance").to_json
    end
  end

  class TestsResource < Resource
    def resource_exists?
      @tests = Test.find(query_ids)
    rescue ActiveRecord::RecordNotFound
      false
    else
      true
    end

    def to_json
      ActiveModel::ArraySerializer.new(@tests, {:root => "tests"}).to_json
    end
  end

  class TestResource < Resource
    def resource_exists?
      begin
        @test = Test.find(request.path_info[:id])
      rescue ActiveRecord::RecordNotFound
        false
      else
        true
      end
    end

    def to_json
      TestSerializer.new(@test, {}).to_json
    end
  end

  Application.routes do
    add ['live'], LiveResource
    add ['scorecards', :id], ScorecardResource
    add ['scorecards'], ScorecardsResource
    add ['artifacts', :id], ArtifactResource
    add ['test_results', :test_result_id, 'artifacts', '*'], ArtifactResource do |request|
      request.post?
    end
    add ['tests', :id], TestResource
    add ['tests'], TestsResource
    add ['test_instances', :id], TestInstanceResource
    add ['test_instances'], TestInstancesResource
    add ['test_results', :id], TestResultResource
    add ['test_results'], TestResultResource do |request|
      request.post?
    end
    add ['test_results'], TestResultsResource
    add ['projects', :name], ProjectResource
    add ['projects'], ProjectsListResource
  end
end

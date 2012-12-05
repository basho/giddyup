require 'stringio'
require 'json'

module GiddyUp
  # When modifying a record, wraps the resource in a transaction that
  # can be rolled back if the request is not successful.
  module TransactionalResource
    # Starts a DB transaction on initialization if the resource
    # indicates it should process inside a transaction.
    def initialize
      if transactional?
        @connection = ActiveRecord::Base.connection
        @connection.begin_db_transaction
      end
    end

    # Rolls back the DB transaction if the response code is not an
    # error (that is, if it's not a 2xx or 3xx response). Otherwise,
    # commits the transaction.
    def finish_request
      if transactional?
        if response.code < 400
          @connection.commit_db_transaction
        else
          @connection.rollback_db_transaction
        end
        ActiveRecord::Base.clear_active_connections!
      end
      super
    end

    # Whether to open a transaction for the request. By default, true.
    def transactional?
      true
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
      # See seancribbs/webmachine-ruby#68
      unless [204, 205, 304].include?(response.code)
        response.headers['Content-Type'] ||= "text/html"
      end
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

  class StreamingResource < Webmachine::Resource
    def initialize
      response.headers['Connection']    ||= 'keep-alive'
      response.headers['Cache-Control'] ||= 'no-cache'
    end

    def allowed_methods
      %W[GET]
    end

    def content_types_provided
      [['text/event-stream', :to_event]]
    end
  end

  class LiveResource < StreamingResource
    def to_event
      Fiber.new do |f|
        $redis.subscribe("test_results") do |on|
          on.message do |channel, msg|
            message = JSON.parse(msg)
            id      = message["id"]
            data    = JSON.generate(message["data"])

            Fiber.yield "id: #{id}\nevent: test_result\ndata: #{data}\n\n"
          end
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

  class LogResource < Resource
    def resource_exists?
      return false unless request.path_info[:id]
      @test_result = TestResult.find(request.path_info[:id])
      @test_result.present?
    end

    def to_json
      LogSerializer.new(@test_result).to_json
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
        scope = scope.includes(:tests)
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
      @scorecard = Scorecard.find(request.path_info[:id])
      @scorecard.present?
    end

    def to_json
      ScorecardSerializer.new(@scorecard, {}).to_json
    end
  end

  Application.routes do
    add ['live'], LiveResource
    add ['scorecards', :id], ScorecardResource
    add ['scorecards'], ScorecardsResource
    add ['logs', :id], LogResource
    add ['test_results', :id], TestResultResource
    add ['test_results'], TestResultResource do |request|
      request.post?
    end
    add ['test_results'], TestResultsResource
    add ['projects', :name], ProjectResource
    add ['projects'], ProjectsListResource
  end
end

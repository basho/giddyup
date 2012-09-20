require 'stringio'
module GiddyUp
  # Base class for resources
  class Resource < Webmachine::Resource
    include Webmachine::Resource::Authentication

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
  end

  # Allows posting of a new test result. This should be in JSON or
  # multipart/form-data, depending on the contents of the log data and
  # the capabilities of the client. Allowing multipart/form-data
  # specifically could support manually uploading test data from a
  # browser.
  class TestResultResource < Resource
    # We open a transaction on initialization so we can grab the next
    # id in create_path.
    def initialize
      TestResult.connection.begin_db_transaction
    end

    def finish_request
      if response.code < 400
        TestResult.connection.commit_db_transaction
      else
        TestResult.connection.rollback_db_transaction
      end
      TestResult.clear_active_connections!
      super
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

  class ProjectsListResource < Resource
    def to_json
      ActiveModel::ArraySerializer.new(Project.all, {
                                         :scope => :list,
                                         :root => "projects"
                                       }).to_json
    end
  end

  class ProjectResource < Resource
    def resource_exists?
      query = Project.where(:name => request.path_info[:name])
      if !request.query.empty?
        query = query.where(['tests.tags::hstore @> ?', HstoreSerializer.dump(request.query)])
      end
      @project = query.first
      @project.present?
    end

    def to_json
      ProjectSerializer.new(@project, {:scope => :single}).to_json
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
    add ['scorecards', :id], ScorecardResource
    add ['test_results', :id], TestResultResource
    add ['test_results'], TestResultResource
    add ['projects', :name], ProjectResource
    add ['projects'], ProjectsListResource
  end
end

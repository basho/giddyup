require 'stringio'
module GiddyUp
  # Base class for resources
  class Resource < Webmachine::Resource
    include Webmachine::Resource::Authentication
    
    def is_authorized?(auth)
      basic_auth(auth, "GiddyUp") do |user, pass|
        user == AUTH_USER && pass == AUTH_PASSWORD
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
    end
    
    def content_types_accepted
      [["application/json", :accept_json],
       ["multipart/form-data", :accept_multipart]]
    end
    
    def resource_exists?; false; end
    def post_is_create?; true; end
    def create_path
      @context = CreateTestResult.new
      URI.join(request.base_uri, "/test_results/#{@context.id}")
    end
    
    def allowed_methods
      ['POST']
    end

    def accept_json
      begin
        data = MultiJson.load(request.body.to_s)
      rescue
        raise Webmachine::MalformedRequest, "Invalid JSON body"
      end
      @context.create_test_result(data)
    end

    def accept_multipart
      begin
        parser = Rack::Multipart::Parser.new('CONTENT_TYPE' => request.content_type,
                                             'CONTENT_LENGTH' => request.content_length,
                                             'rack.input' => StringIO.new(request.body.to_s))
        data = parser.parse
      rescue
        raise Webmachine::MalformedRequest, "Invalid multipart body"
      end
      @context.create_test_result(data)
    end
  end
end

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
      ActiveRecord::Base.connection.begin_db_transaction
    end

    def finish_request
      if response.code < 400
        ActiveRecord::Base.connection.commit_db_transaction
      else
        ActiveRecord::Base.connection.rollback_db_transaction
      end
    end
    
    def content_types_accepted
      [["application/json", :accept_json],
       ["multipart/form-data", :accept_multipart]]
    end
    
    def resource_exists?; false; end
    def post_is_create?; true; end
    def create_path
      next_id = ActiveRecord::Base.connection.serial_sequence TestResult.TestResult.sequence_name
      URI.join(base_uri, 
    end
    
    def allowed_methods
      ['POST']
    end
  end
end

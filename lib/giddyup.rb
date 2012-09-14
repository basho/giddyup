require 'webmachine/adapters/rack'
module GiddyUp
  Application = Webmachine::Application.new do |app|
    app.configure do |config|
      config.adapter = :Rack
    end
  end
end

require 'giddyup/hstore'
require 'giddyup/records'
require 'giddyup/serializers'
require 'giddyup/resources'
require 'giddyup/bootstrap'

require 'webmachine/adapters/rack'
require 'redis'
$redis = Redis.new(:timeout => 0)
module GiddyUp
  Application = Webmachine::Application.new do |app|
    app.configure do |config|
      config.adapter = :Rack
    end
  end

  VERSION_REGEX = /\d+\.\d+\.\d+\w*/

  def self.version(version_string)
    strict = normalize_version(version_string)
    strict.blank? ? version_string : strict
  end

  def self.normalize_version(version_string)
    version_string[VERSION_REGEX, 0]
  end
end

require 'giddyup/hstore'
require 'giddyup/records'
require 'giddyup/serializers'
require 'giddyup/contexts'
require 'giddyup/resources'
require 'giddyup/bootstrap'

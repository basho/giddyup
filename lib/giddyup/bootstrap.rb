### ACTIVERECORD SETUP
require 'uri'
# Extracts the DB url out of the environment
dburl = URI.parse(ENV["DATABASE_URL"])

db_configuration = {
  :adapter => :postgresql,
  :port => dburl.port,
  :host => dburl.host,
  :username => dburl.user,
  :password => dburl.password,
  :database => dburl.path.split("/").last
}

ActiveRecord::Base.establish_connection(db_configuration)

### S3 SETUP
s3config = {
  :provider => 'AWS',
  :aws_access_key_id => ENV['S3_AKID'],
  :aws_secret_access_key => ENV['S3_SECRET']
}

if host = ENV['S3_HOST']
  s3config[:host] = host
end
if port = ENV['S3_PORT']
  s3config[:port] = port
end
if scheme = ENV['S3_SCHEME']
  s3config[:scheme] = scheme
end

GiddyUp::S3 = Fog::Storage.new(s3config)
GiddyUp::LogBucket = ENV['S3_BUCKET']

### BASIC AUTH SETUP
GiddyUp::AUTH_USER = ENV['AUTH_USER']
GiddyUp::AUTH_PASSWORD = ENV['AUTH_PASSWORD']

### EVENTS SETUP

# We can change this later to use whatever as long as we can make the
# API similar. Redis on Heroku is flakey and we only have one server
# process right now.
require 'active_support/notifications'
GiddyUp::Events = ActiveSupport::Notifications

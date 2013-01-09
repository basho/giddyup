$: << 'lib'
require 'rubygems'
require 'bundler'

Bundler.require

require 'amqp'
require 'giddyup'
require 'rack/static'
require 'rack-rewrite'
require 'rake-pipeline'
require 'rake-pipeline/middleware'

Rack::Mime::MIME_TYPES['.woff'] = 'application/x-font-woff'

use Rack::Rewrite do
  rewrite %r{^(.*)\/$}, '$1/index.html'
end

EventMachine.run do
  AMQP.connect(:host => "127.0.0.1") do |connection|
    AMQP.channel ||= AMQP::Channel.new(connection)
    AMQP.channel.queue("events", :auto_delete => true)
  end
end

use Rake::Pipeline::Middleware, "Assetfile"
use Rack::Static, :urls => ["/index.html", "/favicon.ico", "/stylesheets", "/javascripts", "/images"], :root => "public"
run GiddyUp::Application.adapter

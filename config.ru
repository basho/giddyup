$: << 'lib'
require 'rubygems'
require 'bundler'

Bundler.require

require 'giddyup'
require 'rack/static'
require 'rack-rewrite'
require 'rake-pipeline'
require 'rake-pipeline/middleware'

Rack::Mime::MIME_TYPES['.woff'] = 'application/x-font-woff'

use Rack::Rewrite do
  rewrite %r{^(.*)\/$}, '$1/index.html'
end

unless ENV['RACK_ENV'] == 'production'
  use Rake::Pipeline::Middleware, "Assetfile"
end
use Rack::Static, :urls => ["/index.html", "/favicon.ico", "/stylesheets", "/javascripts", "/images", "/fonts"], :root => "public"
run GiddyUp::Application.adapter

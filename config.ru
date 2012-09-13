$: << 'lib'
require 'rubygems'
require 'bundler'

Bundler.require

require 'giddyup'
require 'rack/static'
require 'rake-pipeline'
require 'rake-pipeline/middleware'

use Rake::Pipeline::Middleware, "Assetfile"
use Rack::Static, :urls => ["/index.html", "/favicon.ico", "/css", "/js", "/images"], :root => "public"
run GiddyUp::Application.adapter

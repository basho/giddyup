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

use Rake::Pipeline::Middleware, "Assetfile"
use Rack::Static, :urls => ["/index.html", "/favicon.ico", "/stylesheets", "/javascripts", "/images"], :root => "public"
run GiddyUp::Application.adapter

$: << 'lib'
require 'rubygems'
require 'bundler'

Bundler.require

require 'giddyup'
require 'rack/static'

use Rack::Static, :urls => ["/index.html", "/favicon.ico", "/css", "/js", "/images"], :root => "public"
run GiddyUp::Application.adapter

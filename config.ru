project_root = File.expand_path(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= 'development'
begin
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  require "rubygems"
  require "bundler"
  Bundler.setup
end
$: << 'lib'

require 'lifeline'

Bundler.require

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/lifeline')

use Rack::Static, :urls => ["/css", "/img", "500.html" ], :root => "public"
run Lifeline::App

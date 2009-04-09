gem 'oauth'
require 'oauth'
gem 'json'
require 'json'
gem 'haml', '~>2.0.9'
require 'haml/util'
require 'haml/engine'
gem 'chronic'
require 'chronic'
gem 'curb'
require 'curb'
require 'logger'

gem 'data_objects', '~>0.9.11'
gem 'dm-core', '~>0.9.10'
gem 'dm-types', '~>0.9.10'
gem 'dm-validations', '~>0.9.10'
gem 'dm-timestamps', '~>0.9.10'
require 'dm-core'
require 'dm-types'
require 'dm-validations'
require 'dm-timestamps'
require 'sinatra/base'

root = File.dirname(__FILE__)
require root + '/lifeline/models/user'
require root + '/lifeline/sinatra/app'

module Lifeline
  module Log
    def self.logger
      if @logger.nil?
        @logger        = Logger.new("lifeline.log")
        @logger.level  = Logger::INFO 
      end
      @logger
    end
  end

  module OAuth
    def self.consumer
      ::OAuth::Consumer.new(ENV['LIFELINE_READKEY'],
                            ENV['LIFELINE_READSECRET'],
                            {:site => 'http://twitter.com'})
    end
  end

  def self.retryable(options = {}, &block)
    opts = { :tries => 1, :on => StandardError }.merge(options)
    retry_exception, retries = opts[:on], opts[:tries]

    begin
      return yield
    rescue retry_exception
      retry if (retries -= 1) > 0
    end
    yield
  end
end

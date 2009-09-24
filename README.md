lifeline
========
Another [oauth][oauth] experiment.  Share info with [sinatra][sinatra] and [twitter][twitter].

Installation
============
It's a sinatra app, packaged as a gem, deployed as a rack app.

    % sudo gem install bundler
    % gem bundle
    % bin/rake repackage
    % sudo gem install pkg/lifeline*.gem

Deployment
==========
Use [passenger][passenger] and a config.ru like this:

Example config.ru

    require 'rubygems'
    require 'lifeline'

    DataMapper.setup(:default, "mysql://atmos:s3cr3t@localhost/lifeline_production")

    ENV['LIFELINE_READKEY'] = /\w{18}/.gen  # this should really be what twitter gives you
    ENV['LIFELINE_READSECRET'] = /\w{24}/.gen # this should really be what twitter gives you

    class LifelineSite < Lifeline::App
      set :public,      File.expand_path(File.dirname(__FILE__), "public")
      set :environment, :production
    end

    run LifelineSite

testing
=======
    % gem bundle
    % bin/rake

Then you just run rake...

[sinatra]: http://www.sinatrarb.com
[twitter]: http://twitter.com
[oauth]: http://oauth.net
[passenger]: http://modrails.com

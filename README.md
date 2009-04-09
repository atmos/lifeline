lifeline
========
Another [oauth][oauth] experiment.  Share info with [sinatra][sinatra] and [twitter][twitter].

Installation
============
It's a sinatra app, packaged as a gem, deployed as a rack app.

    % rake repackage
    % sudo gem install pkg/lifeline*.gem

Your basic deps look like this:

    % sudo gem install oauth json haml curb data_objects dm-core dm-types dm-validations dm-timestamps sinatra

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
You need [jacqui][jacqui]'s fork of fakeweb for the time being
    % git clone git://github.com/jacqui/fakeweb.git
    % cd fakeweb
    % rake repackage
    % sudo gem install pkg/fakeweb-1.2.0.gem

Then you just run rake...

[jacqui]: http://github.com/jacqui
[sinatra]: http://www.sinatrarb.com
[twitter]: http://twitter.com
[oauth]: http://oauth.net
[passenger]: http://modrails.com

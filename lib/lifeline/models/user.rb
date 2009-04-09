module Lifeline
  class User
    include DataMapper::Resource
    class  UserCreationError < StandardError; end
    storage_names[:default] = 'lifeline_users'

    property :id, Serial
    property :twitter_id, Integer, :nullable => false, :unique => true
    property :name, String
    property :token, String
    property :secret, String

    property :url, String, :length => 512
    property :avatar, String, :length => 512, :default => 'http://static.twitter.com/images/default_profile_normal.png'

    timestamps :at

    def access_token
      ::OAuth::AccessToken.new(::Lifeline::OAuth.consumer, token, secret)
    end

    def friends_timeline
      response = Lifeline::OAuth.consumer.request(:get, '/statuses/friends_timeline.json?count=25',
                                                  access_token, {:scheme => :query_string})
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body).map { |tweet| tweet if tweet['user']['protected'] == false }.compact
      else
        [ ]
      end
    end

    def self.create_twitter_user(twitter_id)
      content = Curl::Easy.perform("http://twitter.com/users/show/#{twitter_id}.json") do |curl|
        curl.timeout = 30
      end
      user_info = JSON.parse(content.body_str)
      raise UserCreationError.new("Unable to find '#{twitter_id}'") if(user_info['error'] == 'Not found')
      result = unless user_info['error']
        self.first_or_create({:twitter_id => user_info['id']},{
                              :name       => user_info['name'],
                              :avatar     => user_info['profile_image_url'],
                              :url        => 'http://twitter.com/'+user_info['screen_name']})
      end
    rescue JSON::ParserError
      raise UserCreationError.new("Unable to find '#{twitter_id}'")
    end
  end
end

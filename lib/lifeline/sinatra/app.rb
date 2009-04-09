module Lifeline
  class App < Sinatra::Base
    set :views, File.dirname(__FILE__)+'/views'
    enable :sessions
    enable :methodoverride

    helpers do
      def oauth_consumer
        ::Lifeline::OAuth.consumer
      end

      def current_user
        session[:user_id].nil? ? nil : ::Lifeline::User.get(session[:user_id])
      end
    end

    error do
      Lifeline::Log.logger.info env['sinatra.error'].message
      haml :failed
    end

    get '/callback' do
      @request_token = ::OAuth::RequestToken.new(oauth_consumer,
                                                 session[:request_token],
                                                 session[:request_token_secret])

      access_token = @request_token.get_access_token

      oauth_response = oauth_consumer.request(:get, '/account/verify_credentials.json',
                                              access_token, { :scheme => :query_string })
      case oauth_response
      when Net::HTTPSuccess
        @user_info = JSON.parse(oauth_response.body)
        @user = ::Lifeline::User.first_or_create(:twitter_id  => @user_info['id'])  # really wish first_or_create behaved sanely
        @user.name, @user.avatar  = @user_info['name'], @user_info['profile_image_url']
        @user.token, @user.secret = access_token.token, access_token.secret
        @user.url    = 'http://twitter.com/'+@user_info['screen_name']
        @user.save

        session[:user_id] = @user.id
        redirect '/'
      else
        raise ArgumentError.new('Unhandled HTTP Response')
      end
    end

    get '/signup' do
      Lifeline.retryable(:times => 2) do 
        request_token = oauth_consumer.get_request_token
        session[:request_token] = request_token.token
        session[:request_token_secret] = request_token.secret
        redirect request_token.authorize_url
      end
    end

    get '/' do
      if current_user
        @friends_timeline = current_user.friends_timeline
        @since_date = Time.now.to_i
        haml :home
      else
        haml :about
      end
    end

    get '/about' do
      haml :about
    end

    get '/peace' do
      session.clear
      redirect '/'
    end
  end
end

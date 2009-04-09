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
      def distance_of_time_in_words(from_time, to_time)
        distance_in_minutes = ((to_time - from_time) / 60).round

        case distance_in_minutes
          when 0          then "less than a minute"
          when 1          then "1 minute"
          when 2..45      then "#{distance_in_minutes} minutes"
          when 46..90     then "about 1 hour"
          when 90..1440   then "about #{(distance_in_minutes.to_f / 60.0).round} hours"
          when 1441..2880 then "1 day"
          else                 "#{(distance_in_minutes / 1440).round} days"
        end
      end

      def distance_of_time_in_words_to_now(from_time)
        distance_of_time_in_words(Time.parse(from_time), Time.now)
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

    get '/application.js' do
      <<-EOF
$(function() {
  function refresh_page(since_id) {
    $.get("/refresh/"+since_id, function(html) {
      $('ol.statuses').prepend(html)
      $(html).show('Explode',{},500);
    });
  };

  $('ol.statuses').everyTime(50000, function(i) {
    refresh_page($('ol.statuses li')[0]['id'].replace('status_', ''));
  })
});
      EOF
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
        @friends_timeline = current_user.friends_timeline[0..25]
        haml :home
      else
        haml :about
      end
    end

    get '/refresh/:since' do
      if current_user
        @friends_timeline = current_user.friends_timeline(params['since'])
        @friends_timeline = @friends_timeline.reject { |entry| entry['id'] <= params['since'].to_i }.compact
        haml :refresh, :layout => false
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

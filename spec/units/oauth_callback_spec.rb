require File.dirname(__FILE__)+'/../spec_helper'

describe "authenticating with oauth" do
  it "should be successful" do
    login_quentin
  end
  it "should handle an oauth decline" do
    unauthorized_quentin
  end
  it "should initiate an oauth handshake" do
    request_token = mock('RequestToken', {:token => 'foo', :secret => 'bar', :authorize_url => 'http://api.twitter.com/oauth'})
    consumer = mock('Consumer', {:get_request_token => request_token})

    OAuth::Consumer.stub!(:new).and_return(consumer)

    get '/signup'
    last_response.headers['Location'].should eql('http://api.twitter.com/oauth')
  end
end

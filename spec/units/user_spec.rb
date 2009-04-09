require File.dirname(__FILE__) + '/../spec_helper'

describe "Lifeline::User" do
  before(:each) do
    @user = Lifeline::User.gen
  end

  it "should be valid" do
    @user.should be_valid
  end

  it "should be able to populate your token and secret after your user is created" do
    @user.token = nil
    @user.save

    @new_user = Lifeline::User.first(:twitter_id => @user.twitter_id)
    @new_user.token = /\w{16}/.gen
    @new_user.secret = /\w{16}/.gen 
    @new_user.save

    Lifeline::User.get(@new_user.id).token.should_not be_nil
  end

  it "can cache user info from twitter given a username" do
    user = ::Lifeline::User.create_twitter_user('atmos')
    user.url.should eql('http://twitter.com/atmos')
    user.avatar.should_not be_nil
  end

  it "raises errors when its unable to create from twitter given a bad username" do
    lambda { ::Lifeline::User.create_twitter_user(/\w{16}/.gen) }.should raise_error(Lifeline::User::UserCreationError)
  end
end

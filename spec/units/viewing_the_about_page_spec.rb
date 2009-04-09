require File.dirname(__FILE__)+'/../spec_helper'

describe "viewing the about page" do
  it "displays the about page without authentication" do
    get '/about'
    last_response.should have_selector("a[href='/signup']:contains('Get Started')")
  end
  it "displays the about page when requesting / without authentication" do
    get '/'
    last_response.should have_selector("a[href='/signup']:contains('Get Started')")
  end
end

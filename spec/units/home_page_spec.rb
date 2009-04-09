require File.dirname(__FILE__)+'/../spec_helper'

describe "home page" do
  it "can view their friend's timeline" do
    login_quentin

    JSON.should_receive(:parse).and_return(@json_data)

    user = Lifeline::User.first(:twitter_id => 1484261)

    get '/'
    last_response.should have_selector("h1.fancy:contains('Friends Timeline')")
    last_response.should have_selector("ol.statuses#timeline")
    last_response.should have_selector("ol.statuses#timeline > li.hentry > span.thumb.author > a > img")
    last_response.should have_selector("ol.statuses#timeline > li.hentry > span.status-body > span.entry-content")
    last_response.should have_selector("ol.statuses#timeline > li.hentry > span.status-body > span.entry-meta")
  end
  before(:all) do
  @json_data = 
[{"user"=>
   {"name"=>"srbaker",
    "profile_sidebar_fill_color"=>"e0ff92",
    "profile_background_tile"=>false,
    "profile_sidebar_border_color"=>"87bc44",
    "profile_link_color"=>"0000ff",
    "url"=>nil,
    "favourites_count"=>0,
    "id"=>14106454,
    "description"=>nil,
    "profile_text_color"=>"000000",
    "protected"=>false,
    "utc_offset"=>-18000,
    "profile_background_color"=>"9ae4e8",
    "notifications"=>false,
    "screen_name"=>"srbaker",
    "time_zone"=>"Quito",
    "friends_count"=>205,
    "statuses_count"=>837,
    "followers_count"=>167,
    "profile_background_image_url"=>
     "http://static.twitter.com/images/themes/theme1/bg.gif",
    "following"=>true,
    "location"=>nil,
    "created_at"=>"Sun Mar 09 08:07:14 +0000 2008",
    "profile_image_url"=>
     "http://s3.amazonaws.com/twitter_production/profile_images/53649529/Photo_1_normal.jpg"},
  "truncated"=>false,
  "favorited"=>false,
  "text"=>"Need to work on my foosball skills.c",
  "id"=>1480235666,
  "in_reply_to_user_id"=>nil,
  "in_reply_to_status_id"=>nil,
  "source"=>"<a href=\"http://www.nambu.com\">Nambu</a>",
  "in_reply_to_screen_name"=>nil,
  "created_at"=>"Thu Apr 09 00:19:37 +0000 2009"},
 {"user"=>
   {"name"=>"Dave Fayram",
    "profile_sidebar_fill_color"=>"252429",
    "profile_background_tile"=>false,
    "profile_sidebar_border_color"=>"181A1E",
    "profile_link_color"=>"2FC2EF",
    "url"=>nil,
    "favourites_count"=>0,
    "id"=>784519,
    "description"=>"Powerset Developer",
    "protected"=>false,
    "utc_offset"=>-28800,
    "profile_text_color"=>"666666",
    "profile_background_color"=>"1A1B1F",
    "notifications"=>false,
    "screen_name"=>"KirinDave",
    "time_zone"=>"Pacific Time (US & Canada)",
    "friends_count"=>284,
    "statuses_count"=>4442,
    "followers_count"=>536,
    "profile_background_image_url"=>
     "http://static.twitter.com/images/themes/theme1/bg.gif",
    "following"=>false,
    "location"=>"Gilroy, California",
    "created_at"=>"Tue Feb 20 21:36:11 +0000 2007",
    "profile_image_url"=>
     "https://s3.amazonaws.com/twitter_production/profile_images/82630348/SelfPortrait__002_normal.jpg"},
  "truncated"=>false,
  "favorited"=>false,
  "text"=>"@jasonwatkinspdx #ironic #minimalism #onlyhashtags #lol",
  "id"=>1480230854,
  "in_reply_to_user_id"=>10038,
  "in_reply_to_status_id"=>1480220744,
  "source"=>"<a href=\"http://thecosmicmachine.com/eventbox/\">EventBox</a>",
  "in_reply_to_screen_name"=>"jasonwatkinspdx",
  "created_at"=>"Thu Apr 09 00:18:41 +0000 2009"},
 {"user"=>
   {"name"=>"Jason Watkins",
    "profile_sidebar_fill_color"=>"FFF7CC",
    "profile_background_tile"=>false,
    "profile_sidebar_border_color"=>"F2E195",
    "profile_link_color"=>"FF0000",
    "url"=>nil,
    "favourites_count"=>0,
    "id"=>10038,
    "description"=>"",
    "protected"=>false,
    "utc_offset"=>-28800,
    "profile_text_color"=>"0C3E53",
    "profile_background_color"=>"BADFCD",
    "screen_name"=>"jasonwatkinspdx",
    "time_zone"=>"Pacific Time (US & Canada)",
    "notifications"=>true,
    "friends_count"=>135,
    "followers_count"=>141,
    "statuses_count"=>1434,
    "profile_background_image_url"=>
     "http://static.twitter.com/images/themes/theme12/bg.gif",
    "following"=>true,
    "location"=>"iPhone: 45.559498,-122.661041",
    "created_at"=>"Sun Oct 22 04:16:33 +0000 2006",
    "profile_image_url"=>
     "http://s3.amazonaws.com/twitter_production/profile_images/59332917/Photo_6_normal.jpg"},
  "truncated"=>false,
  "favorited"=>false,
  "text"=>
   "Can't think of the last time I hung out in beaverton. It's a weird mix of suits and sixteen year olds.",
  "id"=>1480224504,
  "in_reply_to_user_id"=>nil,
  "in_reply_to_status_id"=>nil,
  "source"=>
   "<a href=\"http://iconfactory.com/software/twitterrific\">twitterrific</a>",
  "in_reply_to_screen_name"=>nil,
  "created_at"=>"Thu Apr 09 00:17:21 +0000 2009"},
 {"user"=>
   {"name"=>"schlickw",
    "profile_sidebar_fill_color"=>"e0ff92",
    "profile_background_tile"=>false,
    "profile_sidebar_border_color"=>"87bc44",
    "profile_link_color"=>"0000ff",
    "url"=>nil,
    "favourites_count"=>0,
    "id"=>16582757,
    "description"=>nil,
    "protected"=>true,
    "utc_offset"=>nil,
    "profile_text_color"=>"000000",
    "profile_background_color"=>"9ae4e8",
    "screen_name"=>"schlickw",
    "time_zone"=>nil,
    "notifications"=>false,
    "friends_count"=>83,
    "followers_count"=>45,
    "statuses_count"=>446,
    "profile_background_image_url"=>
     "http://static.twitter.com/images/themes/theme1/bg.gif",
    "following"=>true,
    "location"=>nil,
    "created_at"=>"Fri Oct 03 19:40:01 +0000 2008",
    "profile_image_url"=>
     "http://s3.amazonaws.com/twitter_production/profile_images/63526391/robinamused_normal.jpg"},
  "truncated"=>false,
  "favorited"=>false,
  "text"=>"KATEE SACKHOFF on Law and Order!!!",
  "id"=>1480192005,
  "in_reply_to_user_id"=>nil,
  "in_reply_to_status_id"=>nil,
  "source"=>
   "<a href=\"http://orangatame.com/products/twitterberry/\">TwitterBerry</a>",
  "in_reply_to_screen_name"=>nil,
  "created_at"=>"Thu Apr 09 00:10:41 +0000 2009"},
 {"user"=>
   {"name"=>"BryanLiles",
    "profile_sidebar_fill_color"=>"F8F8F8",
    "profile_background_tile"=>false,
    "profile_sidebar_border_color"=>"141617",
    "profile_link_color"=>"030005",
    "url"=>"http://smartic.us",
    "favourites_count"=>2,
    "id"=>659933,
    "description"=>"that guy",
    "protected"=>false,
    "utc_offset"=>-18000,
    "profile_text_color"=>"000000",
    "profile_background_color"=>"585858",
    "notifications"=>false,
    "screen_name"=>"bryanl",
    "time_zone"=>"Eastern Time (US & Canada)",
    "friends_count"=>411,
    "statuses_count"=>4392,
    "followers_count"=>944,
    "profile_background_image_url"=>
     "http://s3.amazonaws.com/twitter_production/profile_background_images/3252365/twitter-bg.png",
    "following"=>false,
    "location"=>"Baltimore, MD",
    "created_at"=>"Thu Jan 18 12:47:55 +0000 2007",
    "profile_image_url"=>
     "http://s3.amazonaws.com/twitter_production/profile_images/71274618/Photo_26_normal.jpg"},
  "truncated"=>false,
  "favorited"=>false,
  "text"=>
   "ctags in vim are a drag... or are they?  maybe this is what the doctor ordered.  http://vimeo.com/4069219  #geekvids",
  "id"=>1480187637,
  "in_reply_to_user_id"=>nil,
  "in_reply_to_status_id"=>nil,
  "source"=>"<a href=\"http://www.nambu.com\">Nambu</a>",
  "in_reply_to_screen_name"=>nil,
  "created_at"=>"Thu Apr 09 00:09:48 +0000 2009"}
]
  end
end

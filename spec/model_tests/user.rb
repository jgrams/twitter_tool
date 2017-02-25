require "rails_helper"
require "Time"

RSpec.describe Search, :type => :model do
  before :all do
    @fake_auth_hash = OmniAuth::AuthHash.new ({
       "provider" => "twitter",
            "uid" => "1",
           "info" => {
           "nickname" => "pearloscopy",
               "name" => "John Gruhmyluh",
              "email" => nil,
           "location" => "Chicago, IL",
              "image" => "http://pbs.twimg.com/profile_images/715232782981668864/QlBFwMQV_normal.jpg",
        "description" => "We're all going to die. At least now our tweets will live forever.  Tech, board games, and bikes.",
               "urls" => {
            "Website" => "https://t.co/77p1zm2dwP",
            "Twitter" => "https://twitter.com/pearloscopy"
        }
    },
    "credentials" => {
         "token" => "1",
        "secret" => "2"
    },
          "extra" => {
    }
})
  end

  describe "#find_or_create_from_auth_hash" do
    it "creates a new user from oauth reply, that contains a user token" do
      user = User.find_or_create_from_auth_hash(@fake_auth_hash) 
      expect(user.token).to eq "1"
    end

    it "creates a new user from oauth reply, that contains a user secret" do
      user = User.find_or_create_from_auth_hash(@fake_auth_hash) 
      expect(user.secret).to eq "2"
    end

    it "returns a new user object" do
      user = User.find_or_create_from_auth_hash(@fake_auth_hash) 
      expect(user).to be_an_instance_of(User)
    end
  end

  describe "#twitter" do
    it "creates a new tiwtter client object" do
      expect(User.new.twitter).to be_an_instance_of(Twitter::REST::Client)
    end
  end

end







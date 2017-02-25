require "rails_helper"
require "Time"

RSpec.describe Search, :type => :controller do
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

  describe "#create" do
    it "creates a new user from oauth reply, that contains a user token" do
      auth_hash = @fake_auth_hash
      expect(create).to redirect_to "http://localhost:3000/search/create.pearloscopy"
    end
  end

end







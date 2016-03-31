class TwittersController < ApplicationController

require 'net/http'
require 'net/https'
require 'uri'
require "base64"

def post_to_authorize

  string_certifications = ""+"#{Rails.application.secrets.twitter_public_key}"+":"+"#{Rails.application.secrets.twitter_secret_key}"
  encoded_certifications = Base64.encode64(string_certifications)
  
  headers = {"Authorization": 'Base '+encoded_certifications, "Content-Type": 'application/x-www-form-urlencoded;charsetUTF-8'}
  body = 'grant_type=client_credentialr'
  uri = URI('https://api.twitter.com/oauth2/token')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, initheader = headers)
 # binding.pry
  @response = http.request(request, body = body)

end



def new_twitter_handle
  @twitter_feed = TwitterFeed.new
end

def create_twitter_handle
  @twitter_feed = TwitterFeed.new(twitter_feed_params)
  if @twitter_feed.save
    format.html { redirect_to "show", notice: 'First input was successfully created.' }
  end
end

def show
  @twitter_feed = TwitterFeed.find_by(params[:id])
end

private

def twitter_feed_params
  binding.pry
  params.require(:twitter_feed).permit(:twitter_handle)
end



end

class TwittersController < ApplicationController

require 'net/http'
require 'net/https'
require 'uri'
require "base64"

def post_to_authorize

  string_certifications = "#{Rails.application.secrets.twitter_public_key}:#{Rails.application.secrets.twitter_secret_key}"
  encoded_certifications = Base64.encode64(string_certifications)
  
  headers = {'Authorization' => 'Base ' + encoded_certifications, 'Content-Type' => 'application/x-www-form-urlencoded;charsetUTF-8'}
  body = 'grant_type=client_credentialr'
  uri = URI('https://api.twitter.com/oauth2/token')

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, initheader = headers)
  binding.pry
  @response = http.request(request, body = body)
<<<<<<< HEAD

end


=======
 # params = { <query_hash> } # headers = { <header_hash> } # http = Net::HTTP.new(uri.host, uri.port) # request = Net::HTTP::Get.new(uri.path) # request.set_form_data( params ) # request = Net::HTTP::Get.new( uri.path+ '?' + request.body , headers) # response = http.request(request) end # #Example Twitter Request in Ruby # place Verisign (and all other) certs in /etc/ssl/certs # # # url = URI.parse 'https://api.twitter.com/1.1/'# url << 'database item'# http = Net::HTTP.new(url.host, url.port) # http.ca_path = RootCA # http.verify_mode = OpenSSL::SSL::VERIFY_PEER # http.verify_depth = 9 # request = Net::HTTP::Get.new(url.path) # # handle oauth here, or whatever you need to do... # response = http.request(request)
  # # ... process response ...
end
>>>>>>> 14f116b02b4fa26bb4a3fde3bb107170d5a51bcf

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

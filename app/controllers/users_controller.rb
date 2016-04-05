class UsersController < ApplicationController

# require 'net/http'
# require 'net/https'
# require 'uri'
# require "base64"

# def post_to_authorize

#   string_certifications = "#{Rails.application.secrets.twitter_public_key}:#{Rails.application.secrets.twitter_secret_key}"
#   encoded_certifications = Base64.encode64(string_certifications)
  
#   headers = {'Authorization' => 'Base ' + encoded_certifications, 'Content-Type' => 'application/x-www-form-urlencoded;charsetUTF-8'}
#   body = 'grant_type=client_credentialr'
#   uri = URI('https://api.twitter.com/oauth2/token')

#   http = Net::HTTP.new(uri.host, uri.port)
#   request = Net::HTTP::Post.new(uri.path, initheader = headers)
#   binding.pry
#   @response = http.request(request, body = body)
# end

def create
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  redirect_to tweet_all_path
end

protected

def auth_hash
  request.env['omniauth.auth']
end

end

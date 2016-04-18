class UsersController < ApplicationController

def create
  #creates a new user hash with info from  
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  binding.pry
  redirect_to tweet_show_path
end

protected

def auth_hash
  request.env['omniauth.auth']
end

end

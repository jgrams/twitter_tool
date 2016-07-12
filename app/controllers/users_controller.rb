class UsersController < ApplicationController

def create
  #creates a new user hash with info from OAuth2 created in the model
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  session[:image] = @user.profile_image
  redirect_to search_user_show_path
end

def destroy
  reset_session
  redirect_to root_path
end

protected

def auth_hash
  request.env['omniauth.auth']
end

end

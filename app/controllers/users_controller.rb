class UsersController < ApplicationController
  layout "main", except: [:new]

#params: auth_hash returned from Oauth twitter authentication
#returns: math 
#
# Oauth callback calls this function
# creates a new user instance, sets up a session user_id and redirect to 
def create
  #find or creates a new user hash with info from OAuth2 created in the model
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  redirect_to search_create_path(username: @user.handle)
end

def destroy
  reset_session
  redirect_to root_path
end

def new
  render layout: false
  if current_user
    @search=Search.new
  end
end

protected

def auth_hash
  request.env['omniauth.auth']
end

end

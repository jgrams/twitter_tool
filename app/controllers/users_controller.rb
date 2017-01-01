class UsersController < ApplicationController
  layout "main", except: [:new]

#params: auth_hash returned from Oauth twitter authentication
#returns: 
#
#creates a new user instance, sets up a session user_id and redirect to 
def create
  #creates a new user hash with info from OAuth2 created in the model
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  binding.pry
  #directs to 
  if Search.find_by(username: @user.handle)
    redirect_to search_database_pull_path(@user.handle)
  else
    redirect_to search_twitter_pull_path(@user.handle)
  end
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

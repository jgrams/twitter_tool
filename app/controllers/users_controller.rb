class UsersController < ApplicationController

  def create
    #find or creates a new user hash with info from OAuth2 created in the model
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    binding.pry
    redirect_to new_search_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def new
    binding.pry
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

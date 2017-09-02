class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    # Gramila
    # delete this after testing
    #
    if true
    # if user_exists_in_database(search_username)
    #   redirect_to show(search_username)
    # elsif twitter_search_reply = current_user.twitter.user(search_username)
      #this is a User object from twitter
      search_results = get_search_from_twitter(user_handle_param)
      #make a new object
      search = Search.new do |new_search|
        #integer, forgien key reference
        new_search.user = session[:user_id]
        #integer
        new_search.twitter_id = search_results.id
        #string
        new_search.lang = search_results.lang
        #string
        new_search.location = search_results.location
        #string
        new_search.person_name = search_results.name
        #string
        new_search.screen_name = search_results.screen_name
      end
      # Gramila
      # uncomment and handle duplicate searches
      #search.save!
      search.id = 1
    end
    binding.pry
    redirect_to controller: :tweets, action: :new, search_id: search
  end

  def show(search_username)
    @username = search.search_username
  end

  #the user looked up a handle already in the database, so 
  #return: database object with that username
  def user_exists_in_database(username)
    Search.find_by(username: username)
    #fill in later!
  end

  #get search info from twitter and save them 
  def get_search_from_twitter(username)
    current_user.twitter.user(username)
  rescue Twitter::Error
    redirect_to search_fail_path(username)
  end

  # DATABASE REFACTOR STARTS WITH FRUSTRATION HERE
  #make instance variables by turning hashes of word counts into sorted arrays
  def top_counts(search, count=40)
    binding.pry
    @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
    @content_count = Search.sort_word_count(search.word_count)
    @hashtag_count = Search.sort_word_count(search.hashtag_count)
    @link_count = Search.sort_word_count(search.link_count, 8)
    @username = search.username
  end

  #fail page for error handling and if the username doesn't exist or there were no tweets
  def search_fail(error)
    @error_message =  error.message
    @username = params[:username]
    @search = Search.new
    render :fail
  end

  private

  def user_handle_param
    params.require(:user_handle)
  end
end
class SearchesController < ApplicationController

  def new
    Search.new
  end

  def create(search_username = params[:username])
    #
    # delete this after testing
    #
    if true
    # if get_search_from_database(search_username)
    #   redirect_to show_path(search_username)
    # elsif twitter_search_reply = current_user.twitter.user(search_username)
      if search_results = get_search_from_twitter(search_username)
        new_search = new
        #integer
        new_search.twitter_id = search_results.id
        #string
        new_search.lang = search_results.lang
        #string
        new_search.location = search_results.location
        #string
        new_search.person_name = search_results.person_name
        #string
        new_search.screen_name = search_results.screen_name
        new_search.save
        binding.pry
        #string, not being saved
        @desctiption = search_results.description
        twitter_search_reply.screen_name
        render :new
        redirect_to :controller => :tweets, :action => :create, :search_id => search_results.id
      end
    else 
      raise "Twitter username #{search_username} doesn't exist or is set to private."
    end
  rescue Twitter::Error
    redirect_to search_fail_path(search_params)
  end

  def show(search_username)
    @username = search.search_username
  end

  #the user looked up a handle already in the database, so 
  #return: database object with that username
  def get_search_from_database(username)
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
  def fail
    @username = params[:username]
    @search = Search.new
  end

  private

  def search_params
    params.require(:searches).permit(:username)
  end
end
class SearchesController < ApplicationController
  
  def create
    @search = current_user.searches.new(search_params)
    if current_user.twitter.user(@search.username) && @search.save
      redirect_to search_show_path(search_params)
      else
      redirect_to search_fail_path(search_params)
    end
  end

  def collect_with_max_id(collection="", max_id=nil, &block)
    response = yield(max_id)
    response.each{|tweet| collection << (tweet.text + " ")}
    response.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_tweets(username)
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      #puts in a search or the logged in user's name to the twitter api
      current_user.twitter.user_timeline(username, options)
    end
  end

  #show the user's tweets
  def user_show
    if Search.find_by(username: current_user.handle)
      search = Search.find_by(username: current_user.handle)
      @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
      @content_count = Search.sort_word_count(search.word_count)
      @hashtag_count = Search.sort_word_count(search.hashtag_count)
      @username = search.username
    else
      search = current_user.searches.new username: current_user.handle
      reply = get_tweets(search.username)
      #save the recieved word_count_hash into the database
      word_count_hash = Search.reduce(reply)
      #sanitize word_count from the model
      word_count_hash = Search.drop_stop_words(word_count_hash)
      #update database with categories I'm likely to perform analysis on
      search.word_count = Search.content_words(word_count_hash)
      search.hashtag_count = Search.hashtag_tweets(word_count_hash)
      search.at_tweet_count = Search.at_tweets(word_count_hash)
      search.save
      #returns an array of 20 objects sorted by word_count
      @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
      @content_count = Search.sort_word_count(search.word_count)
      @hashtag_count = Search.sort_word_count(search.hashtag_count)
      @username = search.username
      #@sorted_word_count = @sorted_word_count.sort_by { |word, count| count }.reverse
      #makes a new search object that can be passed along to the search controller
    end
    @search = Search.new
  end

  def show
    #collect the most recent 200 tweets fo search is supplied, or current user if no search supplied, returned as an array
    #if there is a username and it already has content, just look up the search saved in the database.
    #I should add a field where I record the users who have searched and 
    if Search.find_by(username: params[:username])
      search = Search.find_by(username: params[:username])
      @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
      @content_count = Search.sort_word_count(search.word_count)
      @hashtag_count = Search.sort_word_count(search.hashtag_count)
      @username = search.username
    #if there is no search that matches the username, we call on twitter
    else
      search = current_user.searches.new username: (params[:username])
      reply = get_tweets(search.username)
      #save the recieved word_count_hash into the database
      word_count_hash = Search.reduce(reply)
      #sanitize word_count from the model
      word_count_hash = Search.drop_stop_words(word_count_hash)
      #update database with categories I'm likely to perform analysis on
      search.word_count = Search.content_words(word_count_hash)
      search.hashtag_count = Search.hashtag_tweets(word_count_hash)
      search.at_tweet_count = Search.at_tweets(word_count_hash)
      search.save
      #returns an array of 20 objects sorted by word_count
      @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
      @content_count = Search.sort_word_count(search.word_count)
      @hashtag_count = Search.sort_word_count(search.hashtag_count)
      @username = search.username
      #@sorted_word_count = @sorted_word_count.sort_by { |word, count| count }.reverse
      #makes a new search object that can be passed along to the search controller
    end
    @search = Search.new
  end

  def fail
    @search = current_user.searches.new(search_params)
  end


  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

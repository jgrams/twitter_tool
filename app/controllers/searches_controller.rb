class SearchesController < ApplicationController
  
  def create
    @search = current_user.searches.new(search_params)
    if current_user.twitter.user(@search.username) && @search.save
      binding.pry
      redirect_to search_show_path(search_params)
      else
      binding.pry
      redirect_to search_fail_path(search_params)
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def determine_search(search)
    if search.username
      search.username
    elsif current_user.handle
      current_user.handle
    else
      redirect_to search_fail_path(search_params)
    end
  end

  def show
    binding.pry
    string_of_tweets = ""
    #collect the most recent 200 tweets fo search is supplied, or current user if no search supplied, returned as an array
    search = current_user.searches.find_or_create_by(username: params[:username])
    reply = collect_with_max_id do |max_id|
        begin
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        #puts in a search or the logged in user's name to the twitter api
        current_user.twitter.user_timeline(determine_search(search))
        rescue 
          redirect_to search_timeout_path
          return
        end
      end
    reply.each { |tweet| string_of_tweets << (tweet.text + " ") }
    #save the recieved word_count_hash into the database
    word_count_hash = Search.reduce(string_of_tweets)
    #sanitize word_count from the model
    word_count_hash = Search.drop_stop_words(word_count_hash)
    #update model with categories I'm likely to perform analysis on
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
    @search = Search.new
  end

  def fail
    @search = current_user.searches.new(search_params)
    binding.pry
  end


  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

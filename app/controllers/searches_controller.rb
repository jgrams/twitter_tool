class SearchesController < ApplicationController
  
  #check that the search is a valid twitter user, then route to the correct controller
  def create
    if current_user.twitter.user(search_params[:username])
      if Search.find_by(username: search_params[:username])
        redirect_to search_database_show_path(search_params)
      else
        redirect_to search_twitter_show_path(search_params)
      end
    end
  rescue Twitter::Error
    redirect_to search_fail_path(search_params)
  end

  #the user looked up a handle already in the database, so 
  #return: database object with that username
  def database_show
    #find the database object
    incoming_search = Search.find_by(username: params[:username]||current_user.handle)
    #sorts the hash and returns instance variables or sorted arrays for display
    @at_tweet_count = Search.sort_word_count(incoming_search.at_tweet_count)
    @content_count = Search.sort_word_count(incoming_search.word_count)
    @hashtag_count = Search.sort_word_count(incoming_search.hashtag_count)
    @link_count = Search.sort_word_count(incoming_search.link_count, 8)
    @username = incoming_search.username
    @search = Search.new
  end

  #get tweets from twitter and save them 
  def twitter_show
    #database object for the searched user handle    
    search = current_user.searches.new username: params[:username]||current_user.handle
    #a array of hashed tweets from twitter via twitter gem
    reply = get_tweets(search)
    if !reply.empty?
      #sanetizes text by making a new sanetized_text field and running regexes on text
      reply = Search.sanetize_words_matching_regex(reply, 
        #passed in regex matches "http://....", "https://..." 
        #found: http://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string
        /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/,
        #remove any twitter usernames from sanetized string
        # from http://shahmirj.com/blog/extracting-twitter-usertags-using-regex
        /(?<=^|(?<=[^a-zA-Z0-9-_\\.]))@([A-Za-z]+[A-Za-z0-9_]+)/,
        #regex matching any hashtag from http://stackoverflow.com/questions/1563844/best-hashtag-regex 
        /#(\w*[0-9a-zA-Z]+\w*[0-9a-zA-Z])/,
        #gsub sanetizes input with a regex removing all removes all non-alphanumberic characters (perserving spaces)
        /[^0-9a-z@#' ]/i)
      #store database items of the tweet pull
      search.stored_tweets = Search.drop_stop_words(reply)
      search.word_count = Search.string_to_word_count_hash(reply, :sanetized_text)
      search.hashtag_count = Search.array_to_word_count_hash(reply, :hashtags)
      search.at_tweet_count = Search.array_to_word_count_hash(reply, :user_mentions)
      search.link_count = Search.array_to_word_count_hash(reply, :linked_urls)
      #this turnes the value of the hash into a string, which ins't the behavior I want
      search.stored_tweets = reply
      search.save
      #sorts the hash and returns instance variables of sorted arrays for display
      top_counts(search)
      #makes a new search object that can be passed along to the search controller
      @search = Search.new
    else
      redirect_to search_fail_path
    end
  rescue Twitter::Error
    redirect_to search_fail_path(params)
  end

  #returns an array of 200 Twitter::Tweet objects
  #Twitter:tweet is a hash
  #should be moved to the model eventually
  def get_tweets(username)
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      #puts in a search or the logged in user's name to the twitter api
      current_user.twitter.user_timeline(username, options)
    end
  end

  #loop over tweets to get the max number, where I choose what to pull out of the twitter
  #returns an array of hashes composed on various objects 
  #(currently Time, Num, String)
  def collect_with_max_id(collection={}, max_id=nil, &block)
    response = yield(max_id)
    response.each do |tweet|
      collection[tweet.id] = { 
          url: tweet.url, 
          created_at: tweet.created_at, 
          text: tweet.text, 
          linked_media: tweet.media.map { |e|  e.url.to_s }, 
          linked_urls: tweet.urls.map { |e|  e.expanded_url.to_s },
          user_mentions: tweet.user_mentions.map { |e|  e.screen_name },
          hashtags: tweet.hashtags.map { |e|  e.text }
      }
    end
    response.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  #fail page for error handling and if the username doesn't exist or there were no tweets
  def fail
    @username = params[:username]
    @search = Search.new
  end

  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end
end
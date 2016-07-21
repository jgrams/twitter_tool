class SearchesController < ApplicationController
  
  #check that the search is a valid twitter user, then route to the correct controller
  def create
    if current_user.twitter.user(search_params[:username])
      if Search.find_by(username: search_params[:username])
        redirect_to search_database_show_path(search_params)
      else
        redirect_to search_twitter_show_path(search_params)
      end
    else
      redirect_to search_fail_path(search_params)
    end
  end

  #the user looked up a handle already in the database, so we just pull that
  def database_show
    #find the database object
    search = Search.find_by(username: params[:username]||current_user.handle)
    #sorts the hash and returns instance variables or sorted arrays for display
    top_counts(search)
    @search = Search.new
  end

  #the search doesn't exist in the database, so we have to it from twitter and save it 
  def twitter_show
    #database object
    search = current_user.searches.new username: params[:username]||current_user.handle
    #a string of tweets from twitter
    reply = get_tweets(params[:username]||current_user.handle)
    if !reply.empty?
      #passed in regex matches "http://....", "https://..." 
      #found: http://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string
      search.link_count = Search.words_matching_regex(reply, /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/)
      #sanitize input, and split the string on spaces
      #then turn that arry into a hash of word counts with keys being unique words
      reply = Search.word_hash_from_array(Search.sanitize_punctuation(reply).split(' '))
      #placement of this line is important because it's before anything gets dropped
      #cool stat is currently not being used
      @unique_words = reply.count
      #drop stop words from the hash
      reply = Search.drop_stop_words(reply)
      #pull out words not starting with "# or "@" and store them in the database object
      search.word_count = Search.content_words(reply)
      #pull out words starting with "# or "@" and store them in the database object
      search.hashtag_count = Search.words_starting_with_character(reply, "#")
      search.at_tweet_count = Search.words_starting_with_character(reply, "@")
      search.save
      #sorts the hash and returns instance variables or sorted arrays for display
      top_counts(search)
      #makes a new search object that can be passed along to the search controller
      @search = Search.new
    else
      redirect_to search_fail_path
    end
  end

  #make instance variables by turning hashes of word counts into sorted arrays
  def top_counts(search, count=40)
    @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
    @content_count = Search.sort_word_count(search.word_count)
    @hashtag_count = Search.sort_word_count(search.hashtag_count)
    @link_count = Search.sort_word_count(search.link_count, 8)
    @username = search.username
  end

  #fail page for error handling and if the username doesn't exist or there were no tweets
  def fail
    @username = search_params[:username]
  end

  #the next two functions collect the tweet from twitter
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


  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

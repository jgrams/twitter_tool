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
  #return: database object oh handle
  def database_show
    #find the database object
    search = Search.find_by(username: params[:username]||current_user.handle)
    #sorts the hash and returns instance variables or sorted arrays for display
    top_counts(search)
    @search = Search.new
  end

  #get tweets from twitter and save them 
  def twitter_show
    #database object for the searched user handle
    search = current_user.searches.new username: params[:username]||current_user.handle
    #a array of hashed tweets from twitter via twitter gem
    reply = get_tweets(params[:username]||current_user.handle)
    binding.pry
    if !reply.empty?
      tweet_text = reply.text
      #passed in regex matches "http://....", "https://..." 
      #found: http://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string
      search.link_count = Search.words_matching_regex(reply, /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/)
      binding.pry
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
      binding.pry
      @search = Search.new
    else
      redirect_to search_fail_path
    end
  rescue Twitter::Error
    redirect_to search_fail_path(params)
  end

  #returns an array of 200 Twitter::Tweet objects
  #Twitter:tweet is a hash
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
  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    response.each do |tweet|
      collection << { 
        id: tweet.id, 
        url: tweet.url, 
        created_at: tweet.created_at, 
        text: tweet.text, 
        linked_media: tweet.media.map { |e|  e.url.to_s }, 
        linked_urls: tweet.urls.map { |e|  e.expanded_url.to_s },
      }
    end
    response.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
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
    @username = params[:username]
    @search = Search.new
  end





  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

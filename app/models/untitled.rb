def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

def show
    search = current_user.searches.find_or_create_by(username: params[:username])
    current_user.twitter.get_all_tweets(search)
    #make a giant string from the tweets in order to word count them
    string_of_tweets = ""
    tweets.each { |tweet| string_of_tweets << (tweet.text + " ") }
    #save the recieved word_count_hash into the database
    search.word_count =  Search.reduce(string_of_tweets)
    #sanitize word_count from the model
    word_count = Search.drop_stop_words(search.word_count)
    #cut instance variable from word count later in clean up
    #split the word_count hash into interactions and words
    @interaction_count = Search.at_tweets(word_count)
    @content_count = Search.content_words(word_count)
    #returns an array of 20 objects sorted by word_count
    @interaction_count = Search.sort_word_count(@interaction_count)
    @content_count = Search.sort_word_count(@content_count)
    #@sorted_word_count = @sorted_word_count.sort_by { |word, count| count }.reverse
    #makes a new search object that can be passed along to the search controller
    @new_search = current_user.searches.new
    binding.pry
end

  def show
    #collect the most recent 200 tweets fo search is supplied, or current user if no search supplied, returned as an array
    search = current_user.searches.find_or_create_by(username: params[:username])
    binding.pry
    tweets = current_user.twitter.user_timeline(search.username||=current_user.handle, {count: 200, include_rts: true, trim_user: true})
    
    last_tweet = tweets.last.id
    #make a giant string from the tweets in order to word count them
    string_of_tweets = ""
    tweets.each { |tweet| string_of_tweets << (tweet.text + " ") }
    #save the recieved word_count_hash into the database
    search.word_count =  Search.reduce(string_of_tweets)
    #sanitize word_count from the model
    word_count = Search.drop_stop_words(search.word_count)
    #cut instance variable from word count later in clean up
    #split the word_count hash into interactions and words
    @interaction_count = Search.at_tweets(word_count)
    @content_count = Search.content_words(word_count)
    #returns an array of 20 objects sorted by word_count
    @interaction_count = Search.sort_word_count(@interaction_count)
    @content_count = Search.sort_word_count(@content_count)
    #@sorted_word_count = @sorted_word_count.sort_by { |word, count| count }.reverse
    #makes a new search object that can be passed along to the search controller
    @new_search = current_user.searches.new
  end

def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield max_id
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def fetch_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => true}
    options[:max_id] = max_id unless max_id.nil?
    Twitter.user_timeline(user, options)
  end
end
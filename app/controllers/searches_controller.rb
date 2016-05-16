class SearchesController < ApplicationController
  
  def create
    @search = current_user.searches.new(search_params)
    if @search.save
      redirect_to  search_show_path(search_params)
      else
        binding.pry
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def show
    string_of_tweets = ""
    #collect the most recent 200 tweets fo search is supplied, or current user if no search supplied, returned as an array
    search = current_user.searches.find_or_create_by(username: params[:username])
    reply = collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        current_user.twitter.user_timeline(search.username||=current_user.handle, options)
      end
    reply.each { |tweet| string_of_tweets << (tweet.text + " ") }
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



  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

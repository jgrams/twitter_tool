class SearchesController < ApplicationController
  def create
    @search = current_user.searches.new(search_params)
    if @search.save
      redirect_to  search_show_path(search_params)
      else
        binding.pry
    end
  end

  def update_with_word_count
  end

  #copied from tweets controller
  def show
    #collect the most recent 200 tweets fo search is supplied, or ccureent user if no search supplied, returned as an array
    @search = current_user.searches.find_or_create_by(username: params[:username])
    tweets = current_user.twitter.user_timeline(@search.username||=current_user.handle, {count: 200, include_rts: true, trim_user: true})
    #I can simplify this code, move to model
    #make a giant string from the tweets in order to word count them
    string_of_tweets = ""
    tweets.each { |tweet| string_of_tweets << (tweet.text + " ") }
    #save the recieved word_count_hash into the database
    @search.word_count =  Search.reduce(string_of_tweets)
    #return an array for displaying on page
    @sorted_word_count = @search.word_count.sort_by { |word, count| count }.reverse
    #makes a new search object that can be passed along to the search controller
    @new_search = current_user.searches.new
  end

  private

  def search_params
    params.require(:search).permit(:username, :word_count)
  end

end

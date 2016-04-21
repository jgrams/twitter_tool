class SearchesController < ApplicationController
  def create
    #collect the most recent 200 tweets, returned as an array
    @search = current_user.searches.new(search_params)
    if @search.save
      redirect_to  search_show_path(search_params)
      else
        binding.pry
    end
  end

  #copied from tweets controller
  def show
    #collect the most recent 200 tweets fo search is supplied, or ccureent user if no search supplied, returned as an array
    tweets = current_user.twitter.user_timeline(params[:username]||=current_user, {count: 200, include_rts: true, trim_user: true})
    array_of_tweets = []
    #returns an array of tweet texts with identifying data removed
    #I can simplify this code, move to model
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = Search.reduce(array_of_tweets)
    #makes a new search object that can be passed along to the search controller
    @search = current_user.searches.new
  end

  private

  def search_params
    params.require(:search).permit(:username)
  end

end

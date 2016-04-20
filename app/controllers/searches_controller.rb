class SearchesController < ApplicationController
  def tweeter_search
    #collect the most recent 200 tweets, returned as an array
    @search = Search.new(search_params)
    if @search.save
      tweets = current_user.twitter.user_timeline(@search.username, {count: 200, include_rts: true, trim_user: true})
      array_of_tweets = []
      #returns an array of tweet texts with identifying data removed
      #i should move this flattening action to the model eventually
      tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
      @word_count = reduce(array_of_tweets)
    else
      binding.pry
    end
  end

  private

  def search_params
    params.require(:search).permit(:username)
  end

end

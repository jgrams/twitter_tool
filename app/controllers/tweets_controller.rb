class TweetsController < ApplicationController

  def show
    #collect the most recent 200 tweets, returned as an array
    binding.pry
    tweets = current_user.twitter.user_timeline(params[:username]||=current_user, {count: 200, include_rts: true, trim_user: true})
    array_of_tweets = []
    #returns an array of tweet texts with identifying data removed
    #I can simplify this code, move to model
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = Tweet.reduce(array_of_tweets)
    #makes a new search object that can be passed along to the search controller
    @search = current_user.searches.new
  end


end

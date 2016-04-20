class TweetsController < ApplicationController
  def new_search
  end

  #for returning the user image in the header
  def user_image

  end

  def show
    #collect the most recent 200 tweets, returned as an array
    tweets = current_user.twitter.user_timeline({count: 200, include_rts: true, trim_user: true})
    array_of_tweets = []
    #returns an array of tweet texts with identifying data removed
    #I can simplify this code, move to model
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = Tweet.reduce(array_of_tweets)
  end



end

class TweetsController < ApplicationController
  def new_search
  end

  def show
    #collect the most recent 200 tweets, returned as an array
    tweets = current_user.twitter.user_timeline({count: 200, include_rts: true})
    array_of_tweets = []
    #adds the tweet field to 
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = reduce(array_of_tweets)
  end

end

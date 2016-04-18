class TweetsController < ApplicationController
  def new_search
  end

  def show
    #collect the most recent 200 tweets, returned as an array
    tweets = current_user.twitter.user_timeline({count: 200, include_rts: true, trim_user: true})
    array_of_tweets = []
    #returns an array of tweet texts with identifying data removed
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = reduce(array_of_tweets)
  end

  def tweeter_search
    #collect the most recent 200 tweets, returned as an array
    user = #collect params from form
    tweets = current_user.twitter.user_timeline(user, {count: 200, include_rts: true, trim_user: true})
    array_of_tweets = []
    #returns an array of tweet texts with identifying data removed
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = reduce(array_of_tweets)
  end

end

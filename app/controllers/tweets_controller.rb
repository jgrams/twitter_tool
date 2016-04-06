class TweetsController < ApplicationController
  def new_search
    
  	current_user.twitter.user_timeline( ,{count: 200, include_rts: true})
  end

  def show
    #collect the most recent 200 tweets, returned as an array
    tweets = current_user.twitter.user_timeline({count: 200, include_rts: true})
    array_of_tweets = []
    tweets.each {|tweet| array_of_tweets.push(tweet[:text])}
    @word_count = reduce(array_of_tweets)
  end

  def reduce(array_of_strings)
    #return an array of arrays
    all_words = array_of_strings.map {|string| string.downcase.split(" ")}
    all_words = all_words.flatten
    #reduce the array of arrays created above into a hash with words as keys and counts as values
    all_words = all_words.reduce({}) { |h, w| h.update(w => h.fetch(w, 0) + 1) }
    all_words.map{|key, value| Hash[text: key.to_s, weight: value.to_i]}
  end

end

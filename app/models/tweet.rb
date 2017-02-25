class Tweet < ActiveRecord::Base
	belongs_to :search

  def self.get_tweets_from_database(username)
    binding.pry
  end

  def self.get_tweets_from_twitter_api
    binding.pry
  end

  #returns an 200 Twitter::Tweet objects
  #Twitter:tweet is a hash
  def self.get_tweets(search)
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      #puts in a search or the logged in user's name to the twitter api
      binding.pry
      current_user.twitter.user_timeline(search, options)
    end
  end

  #loop over tweets to get the max number, where I choose what to pull out of the twitter
  #returns an hash of hashes composed on various objects 
  #(currently Time, Num, String)
  def self.collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    response.each do |reply_tweet|
      tweet_object = Tweet.new
      tweet_object.text = reply_tweet.text
      tweet_object.url = reply_tweet.url[:path]
      tweet_object.twitter_created_at = reply_tweet.created_at
      tweet_object.sanetized_text = reply_tweet.text
      #I have to make these 4 functions
      tweet_object.TweetHashtags.collect_hashtags(reply_tweet.hashtags)
      tweet_object.collect_user_mentions(reply_tweet.user_mentions)
      tweet_object.collect_linked_urls(reply_tweet.linked_urls)
      tweet_object.collect_linked_media(reply_tweet.linked_media)
    end
    response.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  end
end

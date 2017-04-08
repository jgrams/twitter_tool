class Tweet < ActiveRecord::Base
	belongs_to :search

  def self.get_tweets_from_database(username)
    binding.pry
  end

  def self.get_tweets_from_twitter
    binding.pry
  end

  # @param count [Integer]
  # @return [Array<Twitter::Tweet>]
def collect_with_max_id(collection=[], max_id=nil, search_id, &block)
  response = yield(max_id, search_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, search_id, &block)
end

  #loop over tweets to get the max number, where I choose what to pull out of the twitter
  #returns an hash of hashes composed on various objects 
  #(currently Time, Num, String)
  def self.collect_with_max_id(search_id, collection=[], max_id=nil, &block)
    responses = yield(max_id, search_id)
    responses.each do |reply_tweet|
      tweet_object = Tweet.new
      tweet_object.search_id = search_id
      tweet_object.text = reply_tweet.text
      binding.pry
      tweet_object.twitter_created_at = reply_tweet.created_at
      tweet_object.sanetized_text = reply_tweet.text
      tweet_object.save
      binding.pry
      #I have to make these 4 functions
      #tweet_object.TweetHashtags.collect_hashtags(reply_tweet.hashtags)
      #tweet_object.collect_user_mentions(reply_tweet.user_mentions)
      #tweet_object.collect_linked_urls(reply_tweet.linked_urls)
      #tweet_object.collect_linked_media(reply_tweet.linked_media)
    end
    responses.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  end
end

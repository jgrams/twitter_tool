class Tweet < ActiveRecord::Base
	belongs_to :search

  def self.get_tweets_from_database(username)
    binding.pry
  end

  def self.get_tweets_from_twitter_api
    binding.pry
  end

  #returns an array of 200 Twitter::Tweet objects
  #Twitter:tweet is a hash
  def self.get_tweets(username)
    binding.pry
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      #puts in a search or the logged in user's name to the twitter api
      current_user.twitter.user_timeline(username, options)
    end
  end

  #loop over tweets to get the max number, where I choose what to pull out of the twitter
  #returns an array of hashes composed on various objects 
  #(currently Time, Num, String)
  def self.collect_with_max_id(collection={}, max_id=nil, &block)
    binding.pry
    response = yield(max_id)
    response.each do |tweet|
      new_tweet = Tweet.new
      binding.pry
      collection[tweet.id] = { 
          url: tweet.url, 
          created_at: tweet.created_at, 
          text: tweet.text, 
          linked_media: tweet.media.map { |e|  e.url.to_s }, 
          linked_urls: tweet.urls.map { |e|  e.expanded_url.to_s },
          user_mentions: tweet.user_mentions.map { |e|  e.screen_name },
          hashtags: tweet.hashtags.map { |e|  e.text }
      }
    end
    response.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  end
end

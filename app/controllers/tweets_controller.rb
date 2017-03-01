class TweetsController < ApplicationController

#shouldn't make a new tweet except when 

  def show(tweet_id)
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
    binding.pry
  end

  def create(search_username)
    Tweet::collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      @count = options[:max_id]
      #puts in a search or the logged in user's name to the twitter api
      binding.pry
      current_user.twitter.user_timeline(search_username, options)
    end
  end

  def index
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
    binding.pry
  end

end

class TweetsController < ApplicationController

#shouldn't make a new tweet except when 

  def show(search)
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
    binding.pry
  end

  def create
    search_id = params[:search_id]
    options = {count: 200, include_rts: true}
    Tweet::collect_with_max_id do |max_id, search_id|
      options[:max_id] = max_id unless max_id.nil?
      @count = options[:max_id]
      #puts in a search or the logged in user's name to the twitter api
      current_user.twitter.user_timeline(search_id, options)
    end
  end

  def index(search)
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
    binding.pry
  end

end

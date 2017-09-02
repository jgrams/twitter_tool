class TweetsController < ApplicationController

#shouldn't make a new tweet except when 

  def show(search)
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
  end

  def create
    binding.pry
    Tweet.new(search_id = params.permit(:search_id)[:search_id])
    3.times do 
      loading
    end
  end

  def loading
  end

  # def create
  #   search_id = params[:search_id]
  #   options = {count: 200, include_rts: true}
  #   binding.pry
  #   loading do |search_id, options|
  #     binding.pry
  #     options[:max_id] = max_id unless max_id.nil?
  #     @count = options[:max_id]
  #     #puts in a search or the logged in user's name to the twitter api
  #     current_user.twitter.user_timeline(search_id, options)
  #     responses.empty? ? collection : collect_with_max_id(collection, response.last.id - 1, &block)
  #   end
  # end

  # def loading(search_id, options, &block)
  #   responses = yield(max_id, search_id)
  #   binding.pry

  # end

  def index(search)
    binding.pry
    @tweet = Tweet.find_by id: tweet_id
    binding.pry
  end

  private

  def search_id
    binding.pry
    @at_tweet_count = Search.sort_word_count(search.at_tweet_count)
    @content_count = Search.sort_word_count(search.word_count)
    @hashtag_count = Search.sort_word_count(search.hashtag_count)
    @link_count = Search.sort_word_count(search.link_count, 8)
    @username = search.username
  end

end

class ExamplesController < ApplicationController
  
  def show
    @example = Example.order("RANDOM()").first
    @content_count = Example.sort_word_count(@example.trimmed_content_count)
    @at_tweet_count = Example.sort_word_count(@example.trimmed_at_tweet_count)
    @hashtag_count = Example.sort_word_count(@example.trimmed_hashtag_count)
  end

end

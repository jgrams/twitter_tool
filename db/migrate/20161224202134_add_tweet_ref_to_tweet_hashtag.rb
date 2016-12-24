class AddTweetRefToTweetHashtag < ActiveRecord::Migration
  def change
    add_reference :tweet_hashtags, :tweet, index: true, foreign_key: true
  end
end

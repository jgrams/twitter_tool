class AddTweetRefToTweetLink < ActiveRecord::Migration
  def change
    add_reference :tweet_links, :tweet, index: true, foreign_key: true
  end
end

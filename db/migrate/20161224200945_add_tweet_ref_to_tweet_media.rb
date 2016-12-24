class AddTweetRefToTweetMedia < ActiveRecord::Migration
  def change
    add_reference :tweet_media, :tweet, index: true, foreign_key: true
  end
end

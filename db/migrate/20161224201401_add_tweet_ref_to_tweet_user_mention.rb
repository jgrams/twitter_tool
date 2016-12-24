class AddTweetRefToTweetUserMention < ActiveRecord::Migration
  def change
    add_reference :tweet_user_mentions, :tweet, index: true, foreign_key: true
  end
end

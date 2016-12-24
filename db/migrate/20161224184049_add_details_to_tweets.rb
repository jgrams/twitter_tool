class AddDetailsToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :url, :string
    add_column :tweets, :twitter_created_at, :datetime
    add_column :tweets, :text, :string
    add_column :tweets, :sanetized_text, :string
    add_column :tweets, :tweet_id, :string
  end
end

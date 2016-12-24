class CreateTweetHashtag < ActiveRecord::Migration
  def change
    create_table :tweet_hashtags do |t|
      t.string :hashtag
    end
  end
end

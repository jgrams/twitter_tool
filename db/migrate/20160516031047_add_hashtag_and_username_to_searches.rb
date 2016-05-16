class AddHashtagAndUsernameToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :hashtag_count, :hstore, default: {}, null: false
    add_column :searches, :at_tweet_count, :hstore, default: {}, null: false
  end
end

class RemoveHstoresFromSearches < ActiveRecord::Migration
  def change
    remove_column :searches, :word_count, :hstore
    remove_column :searches, :hashtag_count, :hstore
    remove_column :searches, :at_tweet_count, :hstore
    remove_column :searches, :link_count, :hstore
    remove_column :searches, :stored_tweets, :hstore
  end
end

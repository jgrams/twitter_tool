class AddTweetsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :stored_tweets, :hstore, default: {}, null: false
  end
end

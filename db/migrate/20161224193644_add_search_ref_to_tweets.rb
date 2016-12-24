class AddSearchRefToTweets < ActiveRecord::Migration
  def change
    add_reference :tweets, :search, index: true, foreign_key: true
  end
end

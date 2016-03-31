class CreateTwitterFeeds < ActiveRecord::Migration
  def change
    create_table :twitter_feeds do |t|
      t.string :twitter_handle

      t.timestamps null: false
    end
  end
end

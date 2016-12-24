class CreateTweetLink < ActiveRecord::Migration
  def change
    create_table :tweet_links do |t|
      t.string :link_url
    end
  end
end

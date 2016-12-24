class CreateTweetMedia < ActiveRecord::Migration
  def change
    create_table :tweet_media do |t|
      t.string :media_url
    end
  end
end

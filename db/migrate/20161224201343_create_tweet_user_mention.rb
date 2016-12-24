class CreateTweetUserMention < ActiveRecord::Migration
  def change
    create_table :tweet_user_mentions do |t|
      t.string :user_mention
    end
  end
end

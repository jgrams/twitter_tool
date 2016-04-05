class AddDataToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :body, :string
    add_column :tweets, :user_id, :integer
    add_column :tweets, :time, :datetime
  end
end

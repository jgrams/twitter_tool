class RemoveBodyandtimeFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :body, :string
    remove_column :tweets, :time, :datetime
  end
end

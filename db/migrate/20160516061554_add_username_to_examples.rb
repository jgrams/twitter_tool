class AddUsernameToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :username, :string, null: false
  end
end
class AddFieldsToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :lang, :string
    add_column :searches, :location, :string
    add_column :searches, :person_name, :string
    add_column :searches, :screen_name, :string
    rename_column :searches, :user_id, :twitter_id
  end
end

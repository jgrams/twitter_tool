class AddFieldsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :twitter_id, :integer
    add_column :searches, :lang, :string
    add_column :searches, :location, :string
    add_column :searches, :person_name, :string
    add_column :searches, :screen_name, :string
    add_reference :searches, :user, index: true, foreign_key: true
  end
end

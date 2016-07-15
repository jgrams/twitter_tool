class AddLinkHashToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :link_count, :hstore, default: {}, null: false
  end
end

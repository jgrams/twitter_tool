class AddWordCountHashToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :word_count, :hstore, default: {}, null: false
  end
end

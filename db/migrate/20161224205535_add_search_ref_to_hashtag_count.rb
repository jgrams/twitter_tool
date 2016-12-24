class AddSearchRefToHashtagCount < ActiveRecord::Migration
  def change
    add_reference :hashtag_counts, :search, index: true, foreign_key: true
  end
end

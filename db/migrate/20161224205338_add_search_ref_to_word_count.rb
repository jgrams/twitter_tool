class AddSearchRefToWordCount < ActiveRecord::Migration
  def change
    add_reference :word_counts, :search, index: true, foreign_key: true
  end
end

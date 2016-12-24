class CreateWordCount < ActiveRecord::Migration
  def change
    create_table :word_counts do |t|
      t.string :word
      t.integer :word_count
    end
  end
end

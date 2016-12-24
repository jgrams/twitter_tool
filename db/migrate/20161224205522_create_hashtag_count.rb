class CreateHashtagCount < ActiveRecord::Migration
  def change
    create_table :hashtag_counts do |t|
      t.string :hashtag
      t.integer :hashtag_count
    end
  end
end

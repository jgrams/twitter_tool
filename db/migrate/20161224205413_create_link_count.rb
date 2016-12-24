class CreateLinkCount < ActiveRecord::Migration
  def change
    create_table :link_counts do |t|
      t.string :link
      t.integer :link_count
    end
  end
end

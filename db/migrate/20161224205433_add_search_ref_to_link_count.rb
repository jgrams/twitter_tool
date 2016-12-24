class AddSearchRefToLinkCount < ActiveRecord::Migration
  def change
    add_reference :link_counts, :search, index: true, foreign_key: true
  end
end

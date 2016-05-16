class AddCountHashesToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :hashtag_count, :hstore, default: {}, null: false
    add_column :examples, :at_tweet_count, :hstore, default: {}, null: false
    add_column :examples, :content_count, :hstore, default: {}, null: false
    add_column :examples, :trimmed_hashtag_count, :hstore, default: {}, null: false
    add_column :examples, :trimmed_at_tweet_count, :hstore, default: {}, null: false
    add_column :examples, :trimmed_content_count, :hstore, default: {}, null: false
  end
end
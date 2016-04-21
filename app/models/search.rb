class Search < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence:true

  def self.reduce(long_tweet_string)
    #sanetize input with a regex and downcase and make an array of individual words
    all_words = long_tweet_string.gsub(/[^0-9a-z@# ]/i, '').downcase.split ' '
    #reduce the array of arrays created above into a hash with words as keys and counts as values
    word_count_hash = all_words.reduce({}) { |memo, word| memo.update(word => memo.fetch(word, 0) + 1) }
  word_count_hash
  end
end
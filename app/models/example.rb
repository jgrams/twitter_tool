class Example < ActiveRecord::Base
  #Return an array of top x word_count objects converted to an array
  #default is 40 words 
  #I should not be copying this Search model function here
  def self.sort_word_count(hash, x=40)
    hash.sort_by { |word, count| count.to_i }.reverse.first(x)
  end
end

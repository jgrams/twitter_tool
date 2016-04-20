class Tweet < ActiveRecord::Base
	belongs_to :user
	validates :user_id, :body, presence:true

  def self.reduce(array_of_strings)
    #return an array of arrays
    all_words = array_of_strings.map {|string| string.downcase.split(" ")}
    all_words = all_words.flatten
    #reduce the array of arrays created above into a hash with words as keys and counts as values
    all_words = all_words.reduce({}) { |memo, word| memo.update(word => memo.fetch(word, 0) + 1) }
    all_words.map{|key, value| Hash[text: key.to_s, weight: value.to_i]}
  end


end

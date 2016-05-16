class Search < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence:true

  def self.reduce(long_tweet_string)
    #sanetize input with a regex and downcase and make an array of individual words
    all_words = long_tweet_string.gsub(/[^0-9a-z@#' ]/i, '').downcase.split(' ')
    #reduce the array of arrays created above into a hash with words as keys and counts as values
    all_words.reduce({}) { |memo, word| memo.update(word => memo.fetch(word, 0) + 1) }
  end

  def self.drop_stop_words(hash)
    stop_word_hash = {"a"=>0, "about"=>0, "above"=>0, "after"=>0, "again"=>0, "against"=>0, "all"=>0, "am"=>0, 
      "an"=>0, "and"=>0, "any"=>0, "are"=>0, "aren't"=>0, "as"=>0, "at"=>0, "be"=>0, "because"=>0, "been"=>0, 
      "before"=>0, "being"=>0, "below"=>0, "between"=>0, "both"=>0, "but"=>0, "by"=>0, "can't"=>0, "cannot"=>0, 
      "could"=>0, "couldn't"=>0, "did"=>0, "didn't"=>0, "do"=>0, "does"=>0, "doesn't"=>0, "doing"=>0, "don't"=>0, 
      "down"=>0, "during"=>0, "each"=>0, "few"=>0, "for"=>0, "from"=>0, "further"=>0, "had"=>0, "hadn't"=>0, 
      "has"=>0, "hasn't"=>0, "have"=>0, "haven't"=>0, "having"=>0, "he"=>0, "he'd"=>0, "he'll"=>0, "he's"=>0, 
      "her"=>0, "here"=>0, "here's"=>0, "hers"=>0, "herself"=>0, "him"=>0, "himself"=>0, "his"=>0, "how"=>0, 
      "how's"=>0, "i"=>0, "i'd"=>0, "i'll"=>0, "i'm"=>0, "i've"=>0, "if"=>0, "in"=>0, "into"=>0, "is"=>0, "isn't"=>0, 
      "it"=>0, "it's"=>0, "its"=>0, "itself"=>0, "let's"=>0, "me"=>0, "more"=>0, "most"=>0, "mustn't"=>0, "my"=>0, 
      "myself"=>0, "no"=>0, "nor"=>0, "not"=>0, "of"=>0, "off"=>0, "on"=>0, "once"=>0, "only"=>0, "or"=>0, "other"=>0, 
      "ought"=>0, "our"=>0, "ours"=>0, "ourselves"=>0, "out"=>0, "over"=>0, "own"=>0, "same"=>0, "shan't"=>0, "she"=>0, 
      "she'd"=>0, "she'll"=>0, "she's"=>0, "should"=>0, "shouldn't"=>0, "so"=>0, "some"=>0, "such"=>0, "than"=>0, "that"=>0, 
      "that's"=>0, "the"=>0, "their"=>0, "theirs"=>0, "them"=>0, "themselves"=>0, "then"=>0, "there"=>0, "there's"=>0, "these"=>0, 
      "they"=>0, "they'd"=>0, "they'll"=>0, "they're"=>0, "they've"=>0, "this"=>0, "those"=>0, "through"=>0, "to"=>0, "too"=>0, 
      "under"=>0, "until"=>0, "up"=>0, "very"=>0, "was"=>0, "wasn't"=>0, "we"=>0, "we'd"=>0, "we'll"=>0, "we're"=>0, 
      "we've"=>0, "were"=>0, "weren't"=>0, "what"=>0, "what's"=>0, "when"=>0, "when's"=>0, "where"=>0, "where's"=>0, 
      "which"=>0, "while"=>0, "who"=>0, "who's"=>0, "whom"=>0, "why"=>0, "why's"=>0, "with"=>0, "won't"=>0, "would"=>0, 
      "wouldn't"=>0, "you"=>0, "you'd"=>0, "you'll"=>0, "you're"=>0, "you've"=>0, "your"=>0, "yours"=>0, "yourself"=>0, 
      "yourselves"=>0, "zero"=>0, "rt"=>0, "like"=>0, "just"=>0,
      #add twitter specific hash words starting at rt
    }
    #drop any word in the stop_word_hash
    hash.reject { |key, value| stop_word_hash[key] }
  end
  #pulls out @tweets
  def self.at_tweets(hash)
    hash.select { |key, value| key[0] == "@" }
  end
  #pulls out not @tweets, so content words to add further functionality to
  def self.content_words(hash)
    hash.select { |key, value| key[0] != "@" || key[0] != "#" }
  end

  #pulls out hashtagged content
  def self.hashtag_tweets(hash)
    hash.select { |key, value| key[0] == "#" }
  end

  #Return an array of top x word_count objects converted to an array
  #default is 40 words 
  def self.sort_word_count(hash, x=40)
    hash.sort_by { |word, count| count.to_i }.reverse.first(x)
  end

end
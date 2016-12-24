
#should make the search a has and belongs to many relationship.
class Search < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence:true
  validates :username, presence:true, uniqueness:true

  #takes a array of hashes and deletes words matching the regex
  #agument: hash of , variable number of regex
  #returns: array of hashes with sanetized_text field added if needed and all instances of regex removed
  def self.sanetize_words_matching_regex(tweets, *reg_exes )
    tweets.map do |id, tweet|
      #gsub replaces all instances of regex with an empty string
      reg_exes.each do |regex| 
        text = tweet[:sanetized_text] ? tweet[:sanetized_text] : tweet[:text]
        tweet[:sanetized_text] = text.gsub(regex, '')
      end
      #squish removes multiple spaces and replaces them with single spaces
      tweet[:sanetized_text] = tweet[:sanetized_text].squish.downcase
    end
    tweets
  end

  #argument: hash of tweet objects, a symbol of the key to be read, optionally accepts a hash to update
  #returns: word count hash
  def self.string_to_word_count_hash(tweets, string_key, word_count_hash={})
    tweets.each do |tweet_id, tweet|
      text_array = tweet[string_key].split(' ')
      text_array.each do |word| 
        word_count_hash.update(word_count_hash.fetch(word, {word => {:word_count => 0, :associated_tweet_ids => []}}))
        word_count_hash[word][:word_count] += 1
        word_count_hash[word][:associated_tweet_ids] << tweet_id
      end
    end
    return word_count_hash
    binding.pry
  end

  #argument: hash of tweets, key within hash for an array of words, optionally accepts a hash to update
  #returns: word a count hash of an array of individual words
  def self.array_to_word_count_hash(tweets, symbol_of_array, word_count_hash={})
    tweets.each do |id, tweet|
      text_array = tweet[symbol_of_array]
      text_array.reduce(word_count_hash) do |hash_memo, word|
        hash_memo.update(word => hash_memo.fetch(word, 0) + 1)
      end
    end
    return word_count_hash
  end

  #arguemnt: a hash of word counts
  #returns: hash of word counts with stop words dropped
  def self.drop_stop_words(tweets)
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
      "that's"=>0, "the"=>0, "their"=>0, "theirs"=>0, "ßthem"=>0, "themselves"=>0, "then"=>0, "there"=>0, "there's"=>0, "these"=>0, 
      "they"=>0, "they'd"=>0, "they'll"=>0, "they're"=>0, "they've"=>0, "this"=>0, "those"=>0, "through"=>0, "to"=>0, "too"=>0, 
      "under"=>0, "until"=>0, "up"=>0, "very"=>0, "was"=>0, "wasn't"=>0, "we"=>0, "we'd"=>0, "we'll"=>0, "we're"=>0, 
      "we've"=>0, "were"=>0, "weren't"=>0, "what"=>0, "what's"=>0, "when"=>0, "when's"=>0, "where"=>0, "where's"=>0, 
      "which"=>0, "while"=>0, "who"=>0, "who's"=>0, "whom"=>0, "why"=>0, "why's"=>0, "with"=>0, "won't"=>0, "would"=>0, 
      "wouldn't"=>0, "you"=>0, "you'd"=>0, "you'll"=>0, "you're"=>0, "you've"=>0, "your"=>0, "yours"=>0, "yourself"=>0, 
      "yourselves"=>0, "zero"=>0, "rt"=>0, "like"=>0, "just"=>0, "amp"=>0, "@"=>0, "#"=>0, "il"=>0, "oh"=>0, "'"=>0,
      #add twitter specific hash words starting at rt
    }
    #drop any word in the stop_word_hash
    tweets.reject { |key, value| stop_word_hash[key] }
  end

  def self.find_charged_words(tweets, stop_word_hash={})
    stop_word_hash = {"black"=>0, "blacks"=>0,
    }
    #drop any word in the stop_word_hash
    tweets.reject { |key, value| stop_word_hash[key] }
  end

  #Return an array of top x word_count objects converted to an array
  #note that count starts at 0
  #default is 40 words 
  #return a sorted array of the most common count 
  def self.sort_word_count(hash, count=40)
    binding.pry
    if hash.empty?
      nil
    else 
      hash.sort_by { |word, count| count.to_i }.reverse.first(count)
    end
  end


end
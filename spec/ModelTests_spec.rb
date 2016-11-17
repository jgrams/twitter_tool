require "rails_helper"

RSpec.describe Search, :type => :model do
  before :all do
    @fake_word_hash = {"a"=>1, "about"=>5, "dove"=>15, "-"=>1}
    @search = Search.create username: "fake_user"
    @reply = { 
                798772122147401728: {
                                    :url => {:scheme => "https",
                                             :user => nil,
                                             :password => nil,
                                             :host => "twitter.com",
                                             :port => nil,
                                             :path => "/pearloscopy/status/798772122147401728",
                                             :query => nil,
                                             :fragment => nil},
                                    :created_at => 2016-11-16 06:18:09 +0000,
                                    :text => "RT @jamesrbuk: To repeat: the *serving* head of the NSA just publicly said a \"nation state\" intervened in the election of the next presiden…",
                                    :linked_media => [],
                                    :linked_urls => [],
                                    :user_mentions => ["jamesrbuk"],
                                    :hashtags => []
                                },
                798772122147401728:{
                                    :url => {:scheme => "https",
                                             :user => nil,
                                             :password => nil,
                                             :host => "twitter.com",
                                             :port => nil,
                                             :path => "/pearloscopy/status/1901895984",
                                             :query => nil,
                                             :fragment => nil},
                                           :created_at => 2009-05-24 11:30:50 +0000,
                                                 :text => "I'm pretty sweet at breaking into my own apartment.",
                                         :linked_media => [],
                                          :linked_urls => [],
                                        :user_mentions => [],
                                             :hashtags => []
                                    }
                }
  end

  describe "#sort_word_count" do
    it "takes a hash of word counts and returns sorted arrays of items assigned for the view" do
      tweet = Search.sort_word_count(@fake_word_hash) 
      expect(tweet).to be_kind_of(Array)
    end

    it "returns nil if the hash is empty" do
      expect(Search.sort_word_count({})).to be_nil
    end

    it "returns an array with the length of the second parameter" do
      word_array = Search.sort_word_count(@fake_word_hash, 1) 
      expect(word_array.length).to eq 1
    end
  end

  describe "#drop_stop_words" do
    it "return a hash with stop words dropped" do
      returned_hash = Search.drop_stop_words(@fake_word_hash)
      expect(returned_hash).not_to include("a")
    end
  end

  describe "#sanetize_words_matching_regex" do
    it "takes a  with  dropped" do
      returned_hash = Search.sanetize_words_matching_regex(tweets, )
      expect(returned_hash).not_to include("a")
    end
  end

  describe "#tweet_text_to_word_count_hash" do
    it "return an word_count hash from a hash of tweet objects" do
      returned_hash = Search.drop_stop_words(@fake_word_hash)
      expect(returned_hash).not_to include("a")
    end
  end
end







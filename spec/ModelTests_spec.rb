require "rails_helper"

RSpec.describe Search, :type => :model do
  before :all do
    @fake_word_hash = {"a"=>1, "about"=>5, "dove"=>15}
    @search = Search.create username: "fake_user" 
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
    it "return an hash with stop words dropped" do
      returned_hash = Search.drop_stop_words(@fake_word_hash)
      expect(returned_hash).not_to include("a")
    end
  end
end
require "rails_helper"
require "Time"

RSpec.describe Search, :type => :model do
  before :all do
    @fake_word_hash = {"a"=>1, "about"=>5, "dove"=>15, "-"=>1}
    @search = Search.create username: "fake_user"
    @url_regex = /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?/
    @username_regex = /(?<=^|(?<=[^a-zA-Z0-9-_\\.]))@([A-Za-z]+[A-Za-z0-9_]+)/
    @hashtag_regex = /#(\w*[0-9a-zA-Z]+\w*[0-9a-zA-Z])/
    @alphanumeric_regex = /[^0-9a-z@#' ]/i
    @reply_initial = { 799741033168900097 => {
                                             :url => {:scheme => "https",
                                                        :user => nil,
                                                    :password => nil,
                                                        :host => "twitter.com",
                                                        :port => nil,
                                                        :path => "/pearloscopy/status/799741033168900097",
                                                       :query => nil,
                                                    :fragment => nil},
                                      :created_at => "2016-11-18 22:28:15 +0000".to_time,
                                            :text => "RT @NYTArchives: The #Procrastinators Club of America visits the New York World's Fair a year after it closed, 50 years ago today. https://t…",
                                    :linked_media => [],
                                     :linked_urls => [],
                                   :user_mentions => ["NYTArchives"
                                                      ],
                                        :hashtags => []
                                              }
                      }
    @reply_database_ready = {798772122147401728 => {
                                    :url => {:scheme => "https",
                                             :user => nil,
                                             :password => nil,
                                             :host => "twitter.com",
                                             :port => nil,
                                             :path => "/pearloscopy/status/798772122147401728",
                                             :query => nil,
                                             :fragment => nil},
                                    :created_at => "2016-11-16 06:18:09 +0000".to_time,
                                    :text => "RT @jamesrbuk: To repeat: the *serving* head of the NSA just publicly said a \"nation state\" intervened in the election of the next presiden…",
                                    :linked_media => [],
                                    :linked_urls => [],
                                    :user_mentions => ["jamesrbuk"],
                                    :hashtags => [],
                                    :sanetized_text => "To repeat the serving head of the NSA just publicly said a nation state intervened in the election of the next presiden",
                                },
                             798772122147401729 => {
                                               :url => {  :scheme => "https",
                                                            :user => nil,
                                                        :password => nil,
                                                            :host => "twitter.com",
                                                            :port => nil,
                                                            :path => "/pearloscopy/status/1901895984",
                                                           :query => nil,
                                                        :fragment => nil},
                                                      :created_at => "2009-05-24 11:30:50 +0000".to_time,
                                              :text => "I'm pretty sweet at breaking into my own apartment.",
                                      :linked_media => [],
                                       :linked_urls => [],
                                     :user_mentions => [],
                                          :hashtags => [],
                                    :sanetized_text => "Im pretty sweet at breaking into my own apartment",
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
    it "creates a new sanetized_text key and stashes text there" do
      returned_hash = Search.sanetize_words_matching_regex(@reply_initial, @hashtag_regex)
      expect(returned_hash[799741033168900097]).to include(:sanetized_text)
    end

    it "drops any words matching a series of regex from sanetized_text || text" do
      returned_hash = Search.sanetize_words_matching_regex(@reply_initial, @hashtag_regex, @username_regex, @alphanumeric_regex)
      expect(returned_hash[799741033168900097][:sanetized_text]).not_to include("NYTArchives", "@", "#", "procrastinators")
    end
  end

  describe "#string_to_word_count_hash" do
    it "return a word count hash from a string value in a tweet hash" do
      returned_hash = Search.string_to_word_count_hash(@fake_word_hash, :sanetized_text)
      expect(returned_hash).not_to include("a")
    end
  end

end







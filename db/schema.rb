# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170421061935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hashtag_counts", force: :cascade do |t|
    t.string  "hashtag"
    t.integer "hashtag_count"
    t.integer "search_id"
  end

  add_index "hashtag_counts", ["search_id"], name: "index_hashtag_counts_on_search_id", using: :btree

  create_table "link_counts", force: :cascade do |t|
    t.string  "link"
    t.integer "link_count"
    t.integer "search_id"
  end

  add_index "link_counts", ["search_id"], name: "index_link_counts_on_search_id", using: :btree

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "username"
    t.integer  "twitter_id"
    t.string   "lang"
    t.string   "location"
    t.string   "person_name"
    t.string   "screen_name"
    t.integer  "user_id"
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "tweet_hashtags", force: :cascade do |t|
    t.string  "hashtag"
    t.integer "tweet_id"
  end

  add_index "tweet_hashtags", ["tweet_id"], name: "index_tweet_hashtags_on_tweet_id", using: :btree

  create_table "tweet_links", force: :cascade do |t|
    t.string  "link_url"
    t.integer "tweet_id"
  end

  add_index "tweet_links", ["tweet_id"], name: "index_tweet_links_on_tweet_id", using: :btree

  create_table "tweet_media", force: :cascade do |t|
    t.string  "media_url"
    t.integer "tweet_id"
  end

  add_index "tweet_media", ["tweet_id"], name: "index_tweet_media_on_tweet_id", using: :btree

  create_table "tweet_user_mentions", force: :cascade do |t|
    t.string  "user_mention"
    t.integer "tweet_id"
  end

  add_index "tweet_user_mentions", ["tweet_id"], name: "index_tweet_user_mentions_on_tweet_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "url"
    t.datetime "twitter_created_at"
    t.string   "text"
    t.string   "sanetized_text"
    t.string   "tweet_id"
    t.integer  "search_id"
  end

  add_index "tweets", ["search_id"], name: "index_tweets_on_search_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "handle"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "profile_image"
    t.string   "name"
  end

  create_table "word_counts", force: :cascade do |t|
    t.string  "word"
    t.integer "word_count"
    t.integer "search_id"
  end

  add_index "word_counts", ["search_id"], name: "index_word_counts_on_search_id", using: :btree

  add_foreign_key "hashtag_counts", "searches"
  add_foreign_key "link_counts", "searches"
  add_foreign_key "searches", "users"
  add_foreign_key "tweet_hashtags", "tweets"
  add_foreign_key "tweet_links", "tweets"
  add_foreign_key "tweet_media", "tweets"
  add_foreign_key "tweet_user_mentions", "tweets"
  add_foreign_key "tweets", "searches"
  add_foreign_key "word_counts", "searches"
end

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

ActiveRecord::Schema.define(version: 20161224184604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "examples", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",                            null: false
    t.hstore   "hashtag_count",          default: {}, null: false
    t.hstore   "at_tweet_count",         default: {}, null: false
    t.hstore   "content_count",          default: {}, null: false
    t.hstore   "trimmed_hashtag_count",  default: {}, null: false
    t.hstore   "trimmed_at_tweet_count", default: {}, null: false
    t.hstore   "trimmed_content_count",  default: {}, null: false
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "username"
    t.integer  "user_id"
    t.hstore   "word_count",     default: {}, null: false
    t.hstore   "hashtag_count",  default: {}, null: false
    t.hstore   "at_tweet_count", default: {}, null: false
    t.hstore   "link_count",     default: {}, null: false
    t.hstore   "stored_tweets",  default: {}, null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "url"
    t.datetime "twitter_created_at"
    t.string   "text"
    t.string   "sanetized_text"
    t.string   "tweet_id"
  end

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

end

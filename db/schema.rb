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

ActiveRecord::Schema.define(version: 20140901121721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "article_type"
    t.string   "relative_url"
    t.text     "content"
    t.string   "state"
    t.datetime "list_scraped_at"
    t.datetime "article_scraped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["article_type"], name: "index_articles_on_article_type", using: :btree
  add_index "articles", ["state"], name: "index_articles_on_state", using: :btree

end

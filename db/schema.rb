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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130905105513) do

  create_table "articles", :force => true do |t|
    t.text     "url"
    t.text     "title"
    t.text     "description", :limit => 16777215
    t.text     "text",        :limit => 2147483647
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "image"
  end

  create_table "devices", :force => true do |t|
    t.string   "user_id"
    t.text     "device_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "group_entries", :force => true do |t|
    t.integer  "newssource_id"
    t.integer  "newsgroup_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "newsgroups", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "newssources", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "image"
  end

  add_index "newssources", ["url"], :name => "url", :unique => true

  create_table "unread_articles", :force => true do |t|
    t.integer "newsgroup_id"
    t.integer "article_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "msaccount"
    t.string   "fbaccount"
    t.string   "twaccount"
    t.string   "gpaccount"
    t.string   "key"
  end

end

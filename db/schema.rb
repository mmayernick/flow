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

ActiveRecord::Schema.define(:version => 20111124032743) do

  create_table "comments", :force => true do |t|
    t.text      "content"
    t.string    "byline"
    t.integer   "user_id"
    t.integer   "item_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "comments", ["item_id"], :name => "index_comments_on_item_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "images", :force => true do |t|
    t.integer  "item_id"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["item_id"], :name => "index_images_on_item_id"

  create_table "items", :force => true do |t|
    t.string    "title"
    t.string    "url"
    t.text      "content"
    t.text      "metadata"
    t.string    "name"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "byline"
    t.integer   "comments_count",     :default => 0
    t.integer   "stars_count",        :default => 0
    t.string    "image_content_type"
    t.string    "image_file_name"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
  end

  add_index "items", ["name"], :name => "index_items_on_name"
  add_index "items", ["title"], :name => "index_items_on_title"
  add_index "items", ["url"], :name => "index_items_on_url"
  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "stars", :force => true do |t|
    t.integer "user_id"
    t.integer "item_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "fullname"
    t.string   "url"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "admin",                                   :default => 0
    t.integer  "approved_for_feed",                       :default => 0
    t.datetime "last_checked_at"
    t.string   "api_key"
  end

  add_index "users", ["api_key"], :name => "index_users_on_api_key", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login"

end

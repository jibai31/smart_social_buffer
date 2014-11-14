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

ActiveRecord::Schema.define(version: 20141113170255) do

  create_table "accounts", force: true do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
    t.string  "token"
    t.string  "token_secret"
    t.string  "username"
    t.string  "email"
  end

  add_index "accounts", ["provider", "uid"], name: "index_accounts_on_provider_and_uid", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "blogs", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id", using: :btree

  create_table "buffered_posts", force: true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "run_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buffered_posts", ["message_id"], name: "index_buffered_posts_on_message_id", using: :btree
  add_index "buffered_posts", ["user_id"], name: "index_buffered_posts_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "contents", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.boolean  "activated",      default: true,  null: false
    t.boolean  "post_only_once", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "blog_id"
  end

  add_index "contents", ["blog_id"], name: "index_contents_on_blog_id", using: :btree
  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "content_id"
    t.text     "text",                           null: false
    t.string   "social_network",                 null: false
    t.integer  "post_counter",   default: 0,     null: false
    t.datetime "last_posted_at"
    t.boolean  "post_only_once", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["content_id"], name: "index_messages_on_content_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",               default: "en", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

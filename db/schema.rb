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

ActiveRecord::Schema.define(version: 20150109145829) do

  create_table "accounts", force: true do |t|
    t.integer "user_id"
    t.string  "uid"
    t.string  "token"
    t.string  "token_secret"
    t.string  "username"
    t.string  "email"
    t.string  "avatar"
    t.integer "social_network_id"
  end

  add_index "accounts", ["social_network_id", "uid"], name: "index_accounts_on_social_network_id_and_uid", using: :btree
  add_index "accounts", ["social_network_id"], name: "index_accounts_on_social_network_id", using: :btree
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

  create_table "buffered_days", force: true do |t|
    t.integer  "buffered_week_id"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buffered_days", ["buffered_week_id"], name: "index_buffered_days_on_buffered_week_id", using: :btree

  create_table "buffered_posts", force: true do |t|
    t.integer  "buffered_day_id"
    t.integer  "message_id"
    t.datetime "run_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buffered_posts", ["buffered_day_id"], name: "index_buffered_posts_on_buffered_day_id", using: :btree
  add_index "buffered_posts", ["message_id"], name: "index_buffered_posts_on_message_id", using: :btree

  create_table "buffered_weeks", force: true do |t|
    t.integer  "planning_id"
    t.date     "first_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buffered_weeks", ["planning_id"], name: "index_buffered_weeks_on_planning_id", using: :btree

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
    t.integer  "posts_count",    default: 0,     null: false
  end

  add_index "contents", ["blog_id"], name: "index_contents_on_blog_id", using: :btree
  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "content_id"
    t.text     "text",                              null: false
    t.integer  "posts_count",       default: 0,     null: false
    t.datetime "last_posted_at"
    t.boolean  "post_only_once",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "social_network_id"
  end

  add_index "messages", ["content_id"], name: "index_messages_on_content_id", using: :btree
  add_index "messages", ["social_network_id"], name: "index_messages_on_social_network_id", using: :btree

  create_table "plannings", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plannings", ["account_id"], name: "index_plannings_on_account_id", using: :btree

  create_table "social_networks", force: true do |t|
    t.string   "provider"
    t.string   "name"
    t.boolean  "implemented", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_networks", ["implemented"], name: "index_social_networks_on_implemented", using: :btree
  add_index "social_networks", ["provider"], name: "index_social_networks_on_provider", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language",               default: "en",  null: false
    t.boolean  "admin",                  default: false
    t.boolean  "beta",                   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

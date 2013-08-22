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

ActiveRecord::Schema.define(version: 20120914222414) do

  create_table "branches", force: true do |t|
    t.string   "location"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile"
    t.string   "phone"
  end

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
    t.text     "description"
    t.string   "slug"
    t.integer  "user_id"
    t.boolean  "approved",    default: false
    t.string   "address",     default: ""
    t.integer  "category_id"
    t.string   "currency",    default: "PHP"
    t.string   "website"
    t.string   "phone"
    t.string   "mobile"
  end

  add_index "businesses", ["slug"], name: "index_businesses_on_slug", unique: true

  create_table "catalogs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "business_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalogs", ["slug"], name: "index_catalogs_on_slug", unique: true

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "categories_slug_unique", unique: true

  create_table "features", force: true do |t|
    t.integer  "product_id"
    t.text     "feature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description",      limit: 255
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "photo"
    t.integer  "catalog_id"
    t.boolean  "in_stock",                                              default: true
    t.decimal  "price",                        precision: 10, scale: 2
    t.integer  "category_id"
    t.boolean  "call_for_pricing",                                      default: false
  end

  add_index "products", ["business_id"], name: "index_products_on_business_id"
  add_index "products", ["catalog_id"], name: "index_products_on_catalog_id"
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.boolean  "approved",        default: false
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    t.string   "title",           default: "0"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.boolean  "reported",        default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "username"
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "banned",                   default: false
    t.datetime "last_business_registered"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

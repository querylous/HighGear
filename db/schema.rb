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

ActiveRecord::Schema.define(version: 20161123003221) do

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.string   "food_type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "wrin"
    t.integer  "sort_order"
  end

  add_index "foods", ["user_id"], name: "index_foods_on_user_id"
  add_index "foods", ["wrin"], name: "index_foods_on_wrin"

  create_table "sales_hours", force: :cascade do |t|
    t.datetime "datetime"
    t.integer  "projected_sales"
    t.integer  "actual_sales"
    t.decimal  "projected_vlh",   precision: 3, scale: 2
    t.decimal  "actual_vlh",      precision: 3, scale: 2
    t.integer  "ttl"
    t.integer  "store_number"
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "api_survey_id"
    t.string   "name"
    t.integer  "store"
    t.string   "api_user"
    t.string   "api_user_key"
    t.string   "fc_dt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "surveys", ["api_survey_id"], name: "index_surveys_on_api_survey_id"
  add_index "surveys", ["fc_dt"], name: "index_surveys_on_fc_dt"
  add_index "surveys", ["store"], name: "index_surveys_on_store"

  create_table "users", force: :cascade do |t|
    t.integer  "emp_no"
    t.string   "password_digest"
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.integer  "store_number"
  end

  create_table "waste_counts", force: :cascade do |t|
    t.integer  "count"
    t.integer  "food_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "waste_counts", ["food_id"], name: "index_waste_counts_on_food_id"
  add_index "waste_counts", ["user_id"], name: "index_waste_counts_on_user_id"

end

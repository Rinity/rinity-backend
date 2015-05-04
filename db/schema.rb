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

ActiveRecord::Schema.define(version: 20150504110426) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "city"
  end

  create_table "delayed_jobs", force: :cascade do |t|
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "offices", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "city"
  end

  add_index "offices", ["company_id"], name: "index_offices_on_company_id"

  create_table "rides", force: :cascade do |t|
    t.string   "direction"
    t.datetime "time"
    t.string   "type"
    t.integer  "freeSeats"
    t.string   "fromAddress"
    t.string   "toAddress"
    t.string   "fromCity"
    t.string   "toCity"
    t.integer  "user_id"
    t.string   "status"
    t.integer  "ride_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "office_id"
  end

  add_index "rides", ["office_id"], name: "index_rides_on_office_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "type"
    t.integer  "company_id"
    t.integer  "default_office_id"
    t.string   "authentication_token"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["default_office_id"], name: "index_users_on_default_office_id"

end

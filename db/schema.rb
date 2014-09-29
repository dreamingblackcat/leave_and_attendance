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

ActiveRecord::Schema.define(version: 20140929083846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leave_applications", force: true do |t|
    t.date     "application_date"
    t.integer  "user_id"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "leave_type_id"
  end

  add_index "leave_applications", ["user_id"], name: "index_leave_applications_on_user_id", using: :btree

  create_table "leave_dates", force: true do |t|
    t.date     "date"
    t.integer  "leave_period_id"
    t.boolean  "granted"
    t.integer  "leave_application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leave_dates", ["leave_application_id"], name: "index_leave_dates_on_leave_application_id", using: :btree
  add_index "leave_dates", ["leave_period_id"], name: "index_leave_dates_on_leave_period_id", using: :btree

  create_table "leave_periods", force: true do |t|
    t.string   "name"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "employee_no",            default: "", null: false
    t.date     "date_of_birth"
    t.string   "nrc_number"
    t.string   "bank_card_number"
    t.string   "nationality"
    t.string   "religion"
    t.string   "gender"
    t.string   "phone_no"
    t.string   "blood_type"
    t.date     "joined_date"
    t.date     "left_date"
    t.text     "address"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

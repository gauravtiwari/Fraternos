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

ActiveRecord::Schema.define(version: 20170611164118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_records", force: :cascade do |t|
    t.bigint "meeting_id"
    t.bigint "user_id"
    t.boolean "presence", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id", "user_id"], name: "index_attendance_records_on_meeting_id_and_user_id", unique: true
    t.index ["meeting_id"], name: "index_attendance_records_on_meeting_id"
    t.index ["user_id"], name: "index_attendance_records_on_user_id"
  end

  create_table "fraternities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "fraternity_id"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fraternity_id"], name: "index_meetings_on_fraternity_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "fraternity_id"
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fraternity_id"], name: "index_memberships_on_fraternity_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizer_assignations", force: :cascade do |t|
    t.bigint "organizer_id"
    t.bigint "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_organizer_assignations_on_meeting_id"
    t.index ["organizer_id", "meeting_id"], name: "index_organizer_assignations_on_organizer_id_and_meeting_id", unique: true
    t.index ["organizer_id"], name: "index_organizer_assignations_on_organizer_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "type"
    t.date "date", null: false
    t.decimal "amount", precision: 2, null: false
    t.bigint "fraternity_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fraternity_id"], name: "index_transactions_on_fraternity_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "attendance_records", "meetings"
  add_foreign_key "attendance_records", "users"
  add_foreign_key "meetings", "fraternities"
  add_foreign_key "memberships", "fraternities"
  add_foreign_key "memberships", "users"
  add_foreign_key "organizer_assignations", "meetings"
  add_foreign_key "organizer_assignations", "users", column: "organizer_id"
  add_foreign_key "transactions", "fraternities"
  add_foreign_key "transactions", "users"
end

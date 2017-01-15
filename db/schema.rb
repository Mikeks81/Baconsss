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

ActiveRecord::Schema.define(version: 20170115075603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relationship"
    t.string   "nickname"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "email"
    t.index ["user_id"], name: "index_contacts_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "is_current",    default: false
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "location_role"
    t.index ["user_id"], name: "index_locations_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "transmission"
    t.integer  "user_id"
    t.text     "body"
    t.string   "to"
    t.string   "from"
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "phone_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "contact_id"
    t.index ["contact_id"], name: "index_phones_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_phones_on_user_id", using: :btree
  end

  create_table "profile_contact_joins", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_profile_contact_joins_on_contact_id", using: :btree
    t.index ["profile_id"], name: "index_profile_contact_joins_on_profile_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "text_user_interval"
    t.integer  "response_time"
    t.integer  "text_contact_time"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "active",             default: false
    t.string   "name"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",                 default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "phones", "contacts"
  add_foreign_key "phones", "users"
  add_foreign_key "profile_contact_joins", "contacts"
  add_foreign_key "profile_contact_joins", "profiles"
  add_foreign_key "profiles", "users"
end

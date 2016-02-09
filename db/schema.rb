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

ActiveRecord::Schema.define(version: 20160209055538) do

  create_table "companies", force: :cascade do |t|
    t.string   "company_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "companies_facilities", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "company_id",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "company_facilities", force: :cascade do |t|
    t.integer  "facility_id", limit: 4
    t.integer  "company_id",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "company_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "company_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "code",                        limit: 255
    t.string   "facility_type",               limit: 255
    t.string   "group",                       limit: 255
    t.string   "facility_name",               limit: 255
    t.string   "permit",                      limit: 255
    t.string   "map_label",                   limit: 255
    t.string   "location",                    limit: 255
    t.string   "city",                        limit: 255
    t.string   "county",                      limit: 255
    t.string   "state",                       limit: 255
    t.string   "zip",                         limit: 255
    t.float    "longitude",                   limit: 24
    t.float    "latitude",                    limit: 24
    t.string   "access",                      limit: 255
    t.string   "waste_shed",                  limit: 255
    t.string   "operating_days_and_hours",    limit: 255
    t.string   "days_per_year",               limit: 255
    t.string   "acres",                       limit: 255
    t.string   "total_of_all_wastes_per_day", limit: 255
    t.string   "volume_description",          limit: 255
    t.string   "volume_of_primary_waste",     limit: 255
    t.string   "primary_waste_description",   limit: 255
    t.string   "dollars_per_ton",             limit: 255
    t.string   "tip_fee_description",         limit: 255
    t.string   "remaining_capacity_in_tons",  limit: 255
    t.string   "start_date",                  limit: 255
    t.string   "close_date",                  limit: 255
    t.string   "ownership",                   limit: 255
    t.string   "owner_entity",                limit: 255
    t.string   "owner_code",                  limit: 255
    t.string   "owner_contact",               limit: 255
    t.string   "owner_title",                 limit: 255
    t.string   "owner_department",            limit: 255
    t.string   "owner_address_1",             limit: 255
    t.string   "owner_address_2",             limit: 255
    t.string   "owner_phone",                 limit: 255
    t.string   "owner_fax",                   limit: 255
    t.string   "owner_email",                 limit: 255
    t.string   "operation",                   limit: 255
    t.string   "operator_entity",             limit: 255
    t.string   "operator_code",               limit: 255
    t.string   "operator_contact",            limit: 255
    t.string   "operator_title",              limit: 255
    t.string   "operator_department",         limit: 255
    t.string   "operator_address_1",          limit: 255
    t.string   "operator_address_2",          limit: 255
    t.string   "operator_phone",              limit: 255
    t.string   "operator_fax",                limit: 255
    t.string   "operator_email",              limit: 255
    t.text     "waste_types_accepted",        limit: 65535
    t.string   "facility_alias",              limit: 255
    t.string   "epa_handler_id",              limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_status",         limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

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

ActiveRecord::Schema.define(version: 20150715163004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "applicants", force: :cascade do |t|
    t.integer  "application_case_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.boolean  "is_broker"
  end

  add_index "applicants", ["application_case_id"], name: "index_applicants_on_application_case_id", using: :btree

  create_table "application_cases", force: :cascade do |t|
    t.string   "product"
    t.datetime "expiry"
    t.decimal  "mortgage",            precision: 10, scale: 2
    t.string   "term"
    t.string   "repayment"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "app_type"
    t.integer  "user_id"
    t.integer  "lender_id"
    t.integer  "mortgage_address_id"
    t.decimal  "valuation",           precision: 10, scale: 2
    t.boolean  "archived"
    t.boolean  "active"
    t.text     "reason"
  end

  create_table "application_statuses", force: :cascade do |t|
    t.integer  "application_case_id"
    t.integer  "status_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "application_statuses", ["application_case_id"], name: "index_application_statuses_on_application_case_id", using: :btree
  add_index "application_statuses", ["status_id"], name: "index_application_statuses_on_status_id", using: :btree

  create_table "case_requirements", force: :cascade do |t|
    t.integer  "application_case_id"
    t.integer  "requirement_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "date_requested"
    t.string   "status"
    t.text     "free_requirement"
  end

  add_index "case_requirements", ["application_case_id"], name: "index_case_requirements_on_application_case_id", using: :btree
  add_index "case_requirements", ["requirement_id"], name: "index_case_requirements_on_requirement_id", using: :btree

  create_table "cases", force: :cascade do |t|
    t.string   "valuation"
    t.string   "product"
    t.datetime "expiry"
    t.integer  "mortgage"
    t.string   "term"
    t.string   "repayment"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_addresses", force: :cascade do |t|
    t.string   "address_one"
    t.string   "address_two"
    t.string   "town"
    t.string   "post_code"
    t.boolean  "primary"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contact_addresses", ["user_id"], name: "index_contact_addresses_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.string   "title"
    t.date     "dob"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "extra_details", force: :cascade do |t|
    t.string   "branch"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "extra_details", ["user_id"], name: "index_extra_details_on_user_id", using: :btree

  create_table "lenders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mortgage_addresses", force: :cascade do |t|
    t.string   "address_one"
    t.string   "address_two"
    t.string   "town"
    t.string   "county"
    t.string   "pcode"
    t.integer  "application_case_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "mortgage_addresses", ["application_case_id"], name: "index_mortgage_addresses_on_application_case_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "note"
    t.integer  "application_case_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
  end

  add_index "notes", ["application_case_id"], name: "index_notes_on_application_case_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "phone_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "primary"
  end

  add_index "phone_numbers", ["user_id"], name: "index_phone_numbers_on_user_id", using: :btree

  create_table "requirements", force: :cascade do |t|
    t.string   "requirment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
    t.integer  "contact_id"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "applicants", "application_cases"
  add_foreign_key "application_statuses", "application_cases"
  add_foreign_key "application_statuses", "statuses"
  add_foreign_key "case_requirements", "application_cases"
  add_foreign_key "case_requirements", "requirements"
  add_foreign_key "contact_addresses", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "extra_details", "users"
  add_foreign_key "mortgage_addresses", "application_cases"
  add_foreign_key "notes", "application_cases"
  add_foreign_key "notes", "users"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "users", "roles"
end

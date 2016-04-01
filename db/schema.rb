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

ActiveRecord::Schema.define(version: 20160401120232) do

  create_table "accounts_invoice_items", force: :cascade do |t|
    t.integer  "accounts_invoice_id"
    t.string   "description"
    t.integer  "units"
    t.integer  "unit_cost"
    t.string   "comp_action"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "accounts_invoice_items", ["accounts_invoice_id"], name: "index_accounts_invoice_items_on_accounts_invoice_id"

  create_table "accounts_invoices", force: :cascade do |t|
    t.integer  "training_id"
    t.date     "invoice_date"
    t.text     "invoice_terms"
    t.string   "currency"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "invoice_number"
  end

  add_index "accounts_invoices", ["training_id"], name: "index_accounts_invoices_on_training_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "c_code"
    t.integer  "telephone_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "item"
    t.text     "description"
    t.date     "expense_date"
    t.integer  "qty"
    t.integer  "unit_price"
    t.integer  "tax"
    t.string   "invoice_ref"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "notification"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "opportunities", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "opportunity_status_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "opportunities", ["opportunity_status_id"], name: "index_opportunities_on_opportunity_status_id"
  add_index "opportunities", ["user_id"], name: "index_opportunities_on_user_id"

  create_table "opportunity_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "postal_address"
    t.integer  "country_id"
    t.text     "telephones"
    t.text     "email_address"
    t.text     "website"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "organisations", ["country_id"], name: "index_organisations_on_country_id"

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "other_names"
    t.string   "sex"
    t.string   "passport_no"
    t.string   "job_title"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "participants", ["organisation_id"], name: "index_participants_on_organisation_id"

  create_table "participations", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "profile_bank_details", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bank_details"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "profile_bank_details", ["user_id"], name: "index_profile_bank_details_on_user_id"

  create_table "profile_contact_details", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address"
    t.string   "email_address"
    t.string   "business_phone"
    t.string   "mobile_phone"
    t.string   "home_phone"
    t.string   "fax"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "profile_contact_details", ["user_id"], name: "index_profile_contact_details_on_user_id"

  create_table "profile_general_details", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "education"
    t.string   "staff_id"
    t.date     "date_hired"
    t.string   "passport_number"
    t.string   "drivers_licence"
    t.integer  "salary"
    t.string   "NSSF_number"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.string   "cv_file_name"
    t.string   "cv_content_type"
    t.integer  "cv_file_size"
    t.datetime "cv_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "profile_general_details", ["user_id"], name: "index_profile_general_details_on_user_id"

  create_table "profile_personal_details", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "other_names"
    t.string   "religion"
    t.string   "sex"
    t.string   "marital_status"
    t.date     "birthday"
    t.string   "nationality"
    t.string   "languages"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "profile_personal_details", ["user_id"], name: "index_profile_personal_details_on_user_id"

  create_table "program_dates", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "program_dates", ["program_id"], name: "index_program_dates_on_program_id"

  create_table "program_venues", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "program_venues", ["country_id"], name: "index_program_venues_on_country_id"
  add_index "program_venues", ["program_id"], name: "index_program_venues_on_program_id"

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.text     "description"
    t.boolean  "is_service",  default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "programs", ["category_id"], name: "index_programs_on_category_id"

  create_table "static_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string   "title"
    t.integer  "program_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "fees"
    t.integer  "fees_paid"
    t.integer  "fees_balance"
    t.integer  "program_venue_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "trainings", ["program_id"], name: "index_trainings_on_program_id"
  add_index "trainings", ["program_venue_id"], name: "index_trainings_on_program_venue_id"

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "notification_id"
    t.integer  "user_id"
    t.boolean  "resolved",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "user_notifications", ["notification_id"], name: "index_user_notifications_on_notification_id"
  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.boolean  "is_staff",               default: true
    t.integer  "roles_mask"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end

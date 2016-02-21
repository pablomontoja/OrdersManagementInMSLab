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

ActiveRecord::Schema.define(version: 20160119155857) do

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "institution_id"
    t.integer  "team_id"
    t.string   "email"
    t.string   "phone"
  end

  add_index "clients", ["institution_id"], name: "index_clients_on_institution_id"
  add_index "clients", ["team_id"], name: "index_clients_on_team_id"

  create_table "clients_grants", id: false, force: :cascade do |t|
    t.integer "client_id"
    t.integer "grant_id"
  end

  add_index "clients_grants", ["client_id"], name: "index_clients_grants_on_client_id"
  add_index "clients_grants", ["grant_id"], name: "index_clients_grants_on_grant_id"

  create_table "grants", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "team_id"
    t.boolean  "active",     default: true
  end

  add_index "grants", ["team_id"], name: "index_grants_on_team_id"

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "i_type"
  end

  create_table "measurements", force: :cascade do |t|
    t.decimal  "multiplier",   precision: 4, scale: 2, default: 1.0
    t.decimal  "price",        precision: 7, scale: 2
    t.string   "measured_by"
    t.date     "measured_at"
    t.string   "comment"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "order_id"
    t.integer  "technique_id"
  end

  add_index "measurements", ["order_id"], name: "index_measurements_on_order_id"
  add_index "measurements", ["technique_id"], name: "index_measurements_on_technique_id"

  create_table "orders", force: :cascade do |t|
    t.string   "number"
    t.date     "order_date"
    t.date     "order_end_date"
    t.string   "status"
    t.decimal  "final_price",       precision: 7, scale: 2
    t.string   "created_by"
    t.string   "edited_by"
    t.string   "order_type"
    t.string   "comment"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "sample_name"
    t.integer  "client_id"
    t.integer  "grant_id"
    t.boolean  "sendtojob"
    t.datetime "sendtojobdatetime"
    t.boolean  "sendmail"
  end

  add_index "orders", ["client_id"], name: "index_orders_on_client_id"
  add_index "orders", ["grant_id"], name: "index_orders_on_grant_id"
  add_index "orders", ["number"], name: "index_orders_on_number", unique: true

  create_table "reports", force: :cascade do |t|
    t.string   "name"
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "institution"
    t.integer  "team"
    t.integer  "client"
    t.integer  "grant"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "i_type"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "institution_id"
  end

  add_index "teams", ["institution_id"], name: "index_teams_on_institution_id"

  create_table "techniques", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.decimal  "price_icho",    precision: 7, scale: 2
    t.decimal  "price_ncc",     precision: 7, scale: 2
    t.decimal  "price_cc",      precision: 7, scale: 2
    t.decimal  "price_science", precision: 5, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end

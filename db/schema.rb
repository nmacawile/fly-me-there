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

ActiveRecord::Schema.define(version: 20180105141708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "iata"
    t.string   "municipality"
    t.integer  "country_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["country_id"], name: "index_airports_on_country_id", using: :btree
    t.index ["iata"], name: "index_airports_on_iata", unique: true, using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_bookings_on_flight_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iso"], name: "index_countries_on_iso", unique: true, using: :btree
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.datetime "depart"
    t.datetime "arrive"
    t.integer  "capacity"
    t.decimal  "fare"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["destination_id"], name: "index_flights_on_destination_id", using: :btree
    t.index ["origin_id", "destination_id"], name: "index_flights_on_origin_id_and_destination_id", using: :btree
    t.index ["origin_id"], name: "index_flights_on_origin_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "airports", "countries"
  add_foreign_key "bookings", "flights"
  add_foreign_key "bookings", "users"
  add_foreign_key "flights", "airports", column: "destination_id"
  add_foreign_key "flights", "airports", column: "origin_id"
end

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

ActiveRecord::Schema.define(version: 20160725191600) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coins", force: :cascade do |t|
    t.string   "name"
    t.text     "info_way_to_earn"
    t.string   "info_status"
    t.text     "info_additional"
    t.integer  "price"
    t.integer  "thirty_day_price_change"
    t.integer  "one_day_price_change"
    t.integer  "volume"
    t.integer  "market_cap"
    t.string   "application_name"
    t.text     "application_description"
    t.string   "application_status"
    t.string   "application_category"
    t.string   "logo_url"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "application_url"
    t.string   "coinmarketcap_url"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

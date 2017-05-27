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

ActiveRecord::Schema.define(version: 20170527134714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "coins", force: :cascade do |t|
    t.string   "name"
    t.text     "coin_info"
    t.string   "coin_status"
    t.decimal  "price"
    t.decimal  "one_day_price_change"
    t.integer  "volume"
    t.bigint   "market_cap"
    t.text     "application_description"
    t.integer  "category_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "logo"
    t.string   "slug"
    t.string   "coinmarketcap_url"
    t.bigint   "available_supply"
    t.bigint   "total_supply"
    t.decimal  "one_hour_price_change"
    t.string   "symbol"
    t.integer  "link_id"
    t.integer  "user_id"
    t.integer  "network_id"
    t.integer  "links_id"
    t.jsonb    "repositories",            default: {}, null: false
    t.string   "code_license"
    t.string   "technology"
    t.string   "proof_algorithm"
    t.string   "coin_type"
    t.jsonb    "exchanges",               default: {}, null: false
    t.datetime "saledate"
    t.index ["category_id"], name: "index_coins_on_category_id", using: :btree
    t.index ["links_id"], name: "index_coins_on_links_id", using: :btree
    t.index ["name"], name: "index_coins_on_name", unique: true, using: :btree
    t.index ["network_id"], name: "index_coins_on_network_id", using: :btree
    t.index ["user_id"], name: "index_coins_on_user_id", using: :btree
  end

  create_table "coins_links", id: false, force: :cascade do |t|
    t.integer "coin_id", null: false
    t.integer "link_id", null: false
    t.index ["coin_id", "link_id"], name: "index_coins_links_on_coin_id_and_link_id", using: :btree
    t.index ["link_id", "coin_id"], name: "index_coins_links_on_link_id_and_coin_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "links", force: :cascade do |t|
    t.string   "link"
    t.string   "title"
    t.integer  "category_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "networks",    default: [],              array: true
    t.integer  "coins",       default: [],              array: true
    t.text     "body"
    t.index ["slug"], name: "index_links_on_slug", unique: true, using: :btree
  end

  create_table "links_networks", id: false, force: :cascade do |t|
    t.integer "network_id", null: false
    t.integer "link_id",    null: false
    t.index ["link_id", "network_id"], name: "index_links_networks_on_link_id_and_network_id", using: :btree
    t.index ["network_id", "link_id"], name: "index_links_networks_on_network_id_and_link_id", using: :btree
  end

  create_table "networks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.string   "status"
    t.string   "team"
    t.string   "founders",    default: [],              array: true
    t.string   "slack"
    t.string   "forum"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "slug"
    t.string   "logo"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "coin_id"
    t.index ["category_id"], name: "index_networks_on_category_id", using: :btree
    t.index ["coin_id"], name: "index_networks_on_coin_id", using: :btree
    t.index ["slug"], name: "index_networks_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_networks_on_user_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "slug"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "whitepapers", force: :cascade do |t|
    t.integer  "network_id"
    t.string   "whitepaper"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "whitepaper_title"
    t.string   "slug"
    t.text     "text"
    t.text     "fulltext"
    t.integer  "user_id"
    t.integer  "width"
    t.integer  "height"
  end

  add_foreign_key "coins", "categories"
  add_foreign_key "identities", "users"
end

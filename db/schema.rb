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

ActiveRecord::Schema.define(version: 20170603085637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position_id"
    t.integer "order_id"
    t.integer "quantity", default: 0
    t.boolean "picked", default: false
    t.index ["order_id"], name: "index_baskets_on_order_id"
    t.index ["position_id"], name: "index_baskets_on_position_id"
  end

  create_table "histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "item_id"
    t.string "item_type"
    t.jsonb "actions"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.string "name"
    t.string "barcode"
    t.integer "created_by"
    t.integer "user_id"
    t.datetime "due_at"
    t.string "state", default: "busy"
    t.index ["reference"], name: "index_orders_on_reference"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "depth", default: 0
    t.integer "quantity"
    t.integer "product_id"
    t.integer "free", default: 0
    t.integer "volume", default: 0
    t.integer "width", default: 0
    t.integer "height", default: 0
    t.integer "level", default: 0
    t.index ["free"], name: "index_positions_on_free"
    t.index ["name"], name: "index_positions_on_name"
    t.index ["product_id"], name: "index_positions_on_product_id"
    t.index ["quantity"], name: "index_positions_on_quantity"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.string "name"
    t.integer "quantity", default: 0
    t.string "notes"
    t.string "ean13"
    t.index ["name"], name: "index_products_on_name"
    t.index ["quantity"], name: "index_products_on_quantity"
    t.index ["reference"], name: "index_products_on_reference"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

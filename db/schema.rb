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

ActiveRecord::Schema.define(version: 2020_12_09_234411) do

  create_table "baskets", force: :cascade do |t|
    t.integer "customer_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_info_id"], name: "index_baskets_on_customer_info_id"
  end

  create_table "customer_infos", force: :cascade do |t|
    t.integer "user_id"
    t.string "customerName"
    t.string "telephone"
    t.string "address"
    t.string "city"
    t.string "county"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customer_infos_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "basket_id"
    t.integer "product_id"
    t.integer "quantityOrdered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_items_on_basket_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "basket_id"
    t.string "card_number"
    t.string "svc_number"
    t.text "message"
    t.decimal "orderTotal"
    t.datetime "deliveryDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_orders_on_basket_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.string "image_url"
    t.decimal "price"
    t.integer "quantityInStock"
    t.boolean "has_badge"
    t.boolean "is_new"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.string "title"
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

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

ActiveRecord::Schema.define(version: 20170807220508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "shopify_id", null: false
    t.datetime "shopify_created_at"
    t.datetime "shopify_updated_at"
    t.string "kind", null: false
    t.string "handle"
    t.string "title"
    t.text "body_html"
    t.string "sort_order"
    t.string "template_suffix"
    t.string "published_scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["published_scope"], name: "index_collections_on_published_scope"
    t.index ["shop_id"], name: "index_collections_on_shop_id"
    t.index ["shopify_id"], name: "index_collections_on_shopify_id", unique: true
  end

  create_table "collects", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "collection_shopify_id", null: false
    t.bigint "product_shopify_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_shopify_id", "product_shopify_id"], name: "index_collects_on_collection_shopify_id_and_product_shopify_id", unique: true
    t.index ["shop_id"], name: "index_collects_on_shop_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "shopify_id", null: false
    t.string "title", null: false
    t.text "body_html"
    t.string "product_type"
    t.string "published_scope"
    t.string "image_url"
    t.string "url"
    t.datetime "shopify_created_at"
    t.datetime "shopify_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "handle", null: false
    t.string "vendor"
    t.index ["published_scope"], name: "index_products_on_published_scope"
    t.index ["shop_id"], name: "index_products_on_shop_id"
    t.index ["shopify_id"], name: "index_products_on_shopify_id", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "shopify_id", null: false
    t.string "title", null: false
    t.integer "price", null: false
    t.string "sku"
    t.integer "position"
    t.string "image_url"
    t.string "url"
    t.datetime "shopify_created_at"
    t.datetime "shopify_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["shopify_id"], name: "index_variants_on_shopify_id", unique: true
  end

  add_foreign_key "collections", "shops", on_delete: :cascade
  add_foreign_key "collects", "shops", on_delete: :cascade
  add_foreign_key "products", "shops", on_delete: :cascade
  add_foreign_key "variants", "products", on_delete: :cascade
end

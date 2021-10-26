# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_16_074350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreements", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "service_id", null: false
    t.string "project_name", null: false
    t.decimal "price"
    t.string "unit", default: "", null: false
    t.date "ends_on"
    t.string "state", default: "", null: false
    t.string "purchase_order_number", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_agreements_on_customer_id"
    t.index ["service_id"], name: "index_agreements_on_service_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "tax_id", default: "", null: false
    t.string "tax_region", default: "", null: false
    t.string "invoice_email", default: "", null: false
    t.text "address", default: "", null: false
    t.string "phone", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "economic_debtor_number"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.string "unit", null: false
    t.decimal "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "economic_product_number"
  end

  add_foreign_key "agreements", "customers"
  add_foreign_key "agreements", "services"
end

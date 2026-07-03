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

ActiveRecord::Schema[8.1].define(version: 2026_06_12_104455) do
  create_table "agreements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.integer "discount_percentage", default: 0, null: false
    t.date "ends_on"
    t.integer "float_project_id"
    t.integer "mite_reference"
    t.decimal "price"
    t.string "project_name", null: false
    t.string "purchase_order_number", default: "", null: false
    t.bigint "service_id", null: false
    t.string "state", default: "", null: false
    t.string "unit", default: "", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_agreements_on_customer_id"
    t.index ["service_id"], name: "index_agreements_on_service_id"
  end

  create_table "billable_items", force: :cascade do |t|
    t.integer "agreement_id", null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.string "invoice_reference"
    t.datetime "invoiced_at"
    t.datetime "occurred_at"
    t.decimal "quantity"
    t.string "source"
    t.string "source_key"
    t.string "unit"
    t.datetime "updated_at", null: false
    t.index ["agreement_id"], name: "index_billable_items_on_agreement_id"
    t.index ["source", "source_key"], name: "index_billable_items_on_source_and_source_key", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.text "address", default: "", null: false
    t.string "company_name", null: false
    t.datetime "created_at", null: false
    t.integer "economic_debtor_number"
    t.string "invoice_email", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "tax_id", default: "", null: false
    t.string "tax_region", default: "", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "economic_product_number"
    t.string "name", null: false
    t.decimal "price", null: false
    t.string "unit", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agreements", "customers"
  add_foreign_key "agreements", "services"
  add_foreign_key "billable_items", "agreements"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_01_072842) do

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
    t.string "company_name"
    t.string "tax_id", default: ""
    t.string "tax_region", default: ""
    t.string "invoice_email", default: ""
    t.text "address", default: ""
    t.string "phone", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agreements", "customers"
  add_foreign_key "agreements", "services"
end

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

ActiveRecord::Schema[8.0].define(version: 2025_08_29_071340) do
  create_table "approvals", force: :cascade do |t|
    t.bigint "withdrawal_request_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.datetime "approval_date", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_date"], name: "index_approvals_on_approval_date"
    t.index ["user_id"], name: "index_approvals_on_user_id"
    t.index ["withdrawal_request_id", "user_id"], name: "index_approvals_on_withdrawal_request_id_and_user_id"
    t.index ["withdrawal_request_id"], name: "index_approvals_on_withdrawal_request_id"
  end

  create_table "business_units", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.boolean "active", default: true
    t.string "manager_email"
    t.string "contact_person"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_business_units_on_code", unique: true
    t.index ["name"], name: "index_business_units_on_name"
  end

  create_table "goods_issuance_items", force: :cascade do |t|
    t.bigint "goods_issuance_id", null: false
    t.bigint "withdrawal_request_item_id", null: false
    t.decimal "issued_quantity", precision: 12, scale: 3, null: false
    t.text "notes"
    t.string "barcode_scanned"
    t.datetime "scanned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barcode_scanned"], name: "index_goods_issuance_items_on_barcode_scanned"
    t.index ["goods_issuance_id", "withdrawal_request_item_id"], name: "idx_gi_items_unique", unique: true
  end

  create_table "goods_issuances", force: :cascade do |t|
    t.string "gi_number", null: false
    t.bigint "withdrawal_request_id", null: false
    t.bigint "user_id", null: false
    t.date "issue_date", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.string "sap_document_number"
    t.datetime "sap_posted_at"
    t.text "sap_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gi_number"], name: "index_goods_issuances_on_gi_number", unique: true
    t.index ["sap_document_number"], name: "index_goods_issuances_on_sap_document_number"
    t.index ["status", "issue_date"], name: "index_goods_issuances_on_status_and_issue_date"
    t.index ["user_id"], name: "index_goods_issuances_on_user_id"
    t.index ["withdrawal_request_id"], name: "index_goods_issuances_on_withdrawal_request_id"
  end

  create_table "goods_receipt_items", force: :cascade do |t|
    t.bigint "goods_receipt_id", null: false
    t.bigint "item_id", null: false
    t.decimal "quantity", precision: 12, scale: 3, null: false
    t.decimal "unit_price", precision: 12, scale: 2, null: false
    t.string "warehouse_location"
    t.string "batch_lot"
    t.decimal "available_quantity", precision: 12, scale: 3, null: false
    t.text "remarks"
    t.boolean "quality_passed", default: true
    t.string "inspection_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_lot"], name: "index_goods_receipt_items_on_batch_lot"
    t.index ["goods_receipt_id", "item_id"], name: "index_goods_receipt_items_on_goods_receipt_id_and_item_id", unique: true
    t.index ["goods_receipt_id"], name: "index_goods_receipt_items_on_goods_receipt_id"
    t.index ["item_id"], name: "index_goods_receipt_items_on_item_id"
    t.index ["warehouse_location"], name: "index_goods_receipt_items_on_warehouse_location"
  end

  create_table "goods_receipts", force: :cascade do |t|
    t.string "gr_number", null: false
    t.string "po_reference", null: false
    t.date "receipt_date", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0
    t.text "notes"
    t.boolean "quality_approved", default: false
    t.string "quality_notes"
    t.string "sap_document_number"
    t.datetime "sap_posted_at"
    t.text "sap_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gr_number"], name: "index_goods_receipts_on_gr_number", unique: true
    t.index ["po_reference"], name: "index_goods_receipts_on_po_reference"
    t.index ["sap_document_number"], name: "index_goods_receipts_on_sap_document_number"
    t.index ["status", "receipt_date"], name: "index_goods_receipts_on_status_and_receipt_date"
    t.index ["user_id"], name: "index_goods_receipts_on_user_id"
  end

  create_table "inventory_levels", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "warehouse_location"
    t.string "batch_lot"
    t.decimal "total_quantity", precision: 12, scale: 3, default: 0.0
    t.decimal "available_quantity", precision: 12, scale: 3, default: 0.0
    t.decimal "reserved_quantity", precision: 12, scale: 3, default: 0.0
    t.decimal "reorder_level", precision: 12, scale: 3, default: 0.0
    t.decimal "maximum_level", precision: 12, scale: 3
    t.decimal "unit_cost", precision: 12, scale: 2
    t.decimal "average_monthly_usage", precision: 12, scale: 3, default: 0.0
    t.date "last_receipt_date"
    t.date "last_issue_date"
    t.datetime "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_quantity"], name: "index_inventory_levels_on_available_quantity"
    t.index ["item_id", "available_quantity"], name: "index_inventory_levels_on_item_id_and_available_quantity"
    t.index ["item_id", "warehouse_location", "batch_lot"], name: "idx_inventory_unique", unique: true
    t.index ["warehouse_location"], name: "index_inventory_levels_on_warehouse_location"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_code", null: false
    t.string "description", null: false
    t.string "category"
    t.string "unit_of_measure", default: "EA"
    t.decimal "unit_weight", precision: 10, scale: 3
    t.decimal "standard_cost", precision: 12, scale: 2
    t.boolean "active", default: true
    t.string "barcode"
    t.text "notes"
    t.string "sap_item_code"
    t.datetime "last_sap_sync"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barcode"], name: "index_items_on_barcode", unique: true, where: "([barcode] IS NOT NULL)"
    t.index ["category", "active"], name: "index_items_on_category_and_active"
    t.index ["item_code"], name: "index_items_on_item_code", unique: true
    t.index ["sap_item_code"], name: "index_items_on_sap_item_code"
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "employee_id", null: false
    t.integer "role", default: 0
    t.boolean "active", default: true
    t.bigint "business_unit_id"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_sign_in_at"
    t.datetime "current_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "current_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_unit_id"], name: "index_users_on_business_unit_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["employee_id"], name: "index_users_on_employee_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "withdrawal_request_items", force: :cascade do |t|
    t.bigint "withdrawal_request_id", null: false
    t.bigint "goods_receipt_item_id", null: false
    t.decimal "requested_quantity", precision: 12, scale: 3, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goods_receipt_item_id"], name: "index_withdrawal_request_items_on_goods_receipt_item_id"
    t.index ["withdrawal_request_id", "goods_receipt_item_id"], name: "idx_wr_items_unique", unique: true
    t.index ["withdrawal_request_id"], name: "index_withdrawal_request_items_on_withdrawal_request_id"
  end

  create_table "withdrawal_requests", force: :cascade do |t|
    t.string "wr_number", null: false
    t.bigint "user_id", null: false
    t.bigint "business_unit_id", null: false
    t.bigint "goods_receipt_id", null: false
    t.date "request_date", null: false
    t.date "required_date"
    t.integer "status", default: 0
    t.integer "priority", default: 1
    t.text "purpose"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_unit_id"], name: "index_withdrawal_requests_on_business_unit_id"
    t.index ["goods_receipt_id"], name: "index_withdrawal_requests_on_goods_receipt_id"
    t.index ["status", "request_date"], name: "index_withdrawal_requests_on_status_and_request_date"
    t.index ["user_id"], name: "index_withdrawal_requests_on_user_id"
    t.index ["wr_number"], name: "index_withdrawal_requests_on_wr_number", unique: true
  end

  add_foreign_key "approvals", "users"
  add_foreign_key "approvals", "withdrawal_requests"
  add_foreign_key "goods_issuance_items", "goods_issuances"
  add_foreign_key "goods_issuance_items", "withdrawal_request_items"
  add_foreign_key "goods_issuances", "users"
  add_foreign_key "goods_issuances", "withdrawal_requests"
  add_foreign_key "goods_receipt_items", "goods_receipts"
  add_foreign_key "goods_receipt_items", "items"
  add_foreign_key "goods_receipts", "users"
  add_foreign_key "inventory_levels", "items"
  add_foreign_key "users", "business_units"
  add_foreign_key "withdrawal_request_items", "goods_receipt_items"
  add_foreign_key "withdrawal_request_items", "withdrawal_requests"
  add_foreign_key "withdrawal_requests", "business_units"
  add_foreign_key "withdrawal_requests", "goods_receipts"
  add_foreign_key "withdrawal_requests", "users"
end

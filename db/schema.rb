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

ActiveRecord::Schema[7.0].define(version: 2022_04_27_214724) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "patient_admissions", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patient_admissions_on_patient_id"
  end

  create_table "patient_exits", force: :cascade do |t|
    t.bigint "patient_admission_id", null: false
    t.date "date"
    t.string "reason"
    t.string "location"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_admission_id"], name: "index_patient_exits_on_patient_admission_id"
  end

  create_table "patient_expenses", force: :cascade do |t|
    t.bigint "patient_file_id", null: false
    t.string "description"
    t.decimal "amount"
    t.date "date"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "patient_id"
    t.bigint "patient_receivable_id"
    t.index ["patient_file_id"], name: "index_patient_expenses_on_patient_file_id"
    t.index ["patient_id"], name: "index_patient_expenses_on_patient_id"
    t.index ["patient_receivable_id"], name: "index_patient_expenses_on_patient_receivable_id"
  end

  create_table "patient_files", force: :cascade do |t|
    t.bigint "patient_admission_id", null: false
    t.date "open_date"
    t.date "close_date"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "facility", null: false
    t.index ["patient_admission_id"], name: "index_patient_files_on_patient_admission_id"
  end

  create_table "patient_payments", force: :cascade do |t|
    t.bigint "patient_id"
    t.date "date"
    t.decimal "amount"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "method", null: false
    t.integer "accountable", default: 0, null: false
    t.index ["patient_id"], name: "index_patient_payments_on_patient_id"
  end

  create_table "patient_receivables", force: :cascade do |t|
    t.bigint "patient_file_id", null: false
    t.decimal "amount"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "patient_id"
    t.string "description", null: false
    t.bigint "patient_payment_id"
    t.string "note"
    t.integer "accountable", default: 0, null: false
    t.integer "source", default: 2, null: false
    t.index ["patient_file_id"], name: "index_patient_receivables_on_patient_file_id"
    t.index ["patient_id"], name: "index_patient_receivables_on_patient_id"
    t.index ["patient_payment_id"], name: "index_patient_receivables_on_patient_payment_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.date "date_of_birth"
    t.integer "status", default: 1, null: false
    t.string "citizen_num"
    t.string "nif_num"
    t.string "health_num"
    t.string "social_security_num"
    t.string "clothes_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex", null: false
    t.decimal "monthly_fee"
    t.decimal "balance", default: "0.0", null: false
    t.integer "covenant", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 4, null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "patient_admissions", "patients"
  add_foreign_key "patient_exits", "patient_admissions"
  add_foreign_key "patient_expenses", "patient_files"
  add_foreign_key "patient_expenses", "patient_receivables"
  add_foreign_key "patient_expenses", "patients"
  add_foreign_key "patient_files", "patient_admissions"
  add_foreign_key "patient_payments", "patients"
  add_foreign_key "patient_receivables", "patient_files"
  add_foreign_key "patient_receivables", "patient_payments"
  add_foreign_key "patient_receivables", "patients"
end

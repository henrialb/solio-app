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

ActiveRecord::Schema[7.0].define(version: 2022_04_02_104356) do
  create_table "patient_admissions", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patient_admissions_on_patient_id"
  end

  create_table "patient_exits", force: :cascade do |t|
    t.integer "patient_admission_id", null: false
    t.date "date"
    t.string "reason"
    t.string "location"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_admission_id"], name: "index_patient_exits_on_patient_admission_id"
  end

  create_table "patient_expenses", force: :cascade do |t|
    t.integer "patient_file_id", null: false
    t.string "description"
    t.decimal "amount"
    t.date "date"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
    t.integer "patient_receivable_id"
    t.index ["patient_file_id"], name: "index_patient_expenses_on_patient_file_id"
    t.index ["patient_id"], name: "index_patient_expenses_on_patient_id"
    t.index ["patient_receivable_id"], name: "index_patient_expenses_on_patient_receivable_id"
  end

  create_table "patient_files", force: :cascade do |t|
    t.integer "patient_admission_id", null: false
    t.date "open_date"
    t.date "close_date"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "facility"
    t.index ["patient_admission_id"], name: "index_patient_files_on_patient_admission_id"
  end

  create_table "patient_payments", force: :cascade do |t|
    t.integer "patient_id"
    t.date "date"
    t.decimal "amount"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "method"
    t.integer "accountable", default: 0
    t.index ["patient_id"], name: "index_patient_payments_on_patient_id"
  end

  create_table "patient_receivables", force: :cascade do |t|
    t.integer "patient_file_id", null: false
    t.decimal "amount"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
    t.string "description"
    t.integer "patient_payment_id"
    t.string "note"
    t.integer "accountable", default: 0
    t.integer "source", default: 2
    t.index ["patient_file_id"], name: "index_patient_receivables_on_patient_file_id"
    t.index ["patient_id"], name: "index_patient_receivables_on_patient_id"
    t.index ["patient_payment_id"], name: "index_patient_receivables_on_patient_payment_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.date "dob"
    t.integer "status", default: 1
    t.string "citizen_no"
    t.string "nif_no"
    t.string "health_no"
    t.string "social_security_no"
    t.string "clothes_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex"
    t.decimal "monthly_fee"
    t.decimal "balance", default: "0.0"
    t.integer "covenant", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 4
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

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

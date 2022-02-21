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

ActiveRecord::Schema.define(version: 2022_02_17_015908) do

  create_table "employee_admissions", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employee_admissions_on_employee_id"
  end

  create_table "employee_exits", force: :cascade do |t|
    t.integer "employee_admission_id", null: false
    t.date "date"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_admission_id"], name: "index_employee_exits_on_employee_admission_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "full_name"
    t.string "name"
    t.boolean "is_active", default: true
    t.string "address"
    t.string "citizen_no"
    t.string "nif_no"
    t.string "health_no"
    t.string "phone"
    t.string "email"
    t.string "role"
    t.date "dob"
    t.string "nationality"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "patient_admissions", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patient_admissions_on_patient_id"
  end

  create_table "patient_exits", force: :cascade do |t|
    t.integer "patient_admission_id", null: false
    t.date "date"
    t.string "reason"
    t.string "location"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_admission_id"], name: "index_patient_exits_on_patient_admission_id"
  end

  create_table "patient_expenses", force: :cascade do |t|
    t.integer "patient_file_id", null: false
    t.string "description"
    t.decimal "amount"
    t.date "date"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_admission_id"], name: "index_patient_files_on_patient_admission_id"
  end

  create_table "patient_payments", force: :cascade do |t|
    t.integer "patient_id"
    t.date "date"
    t.decimal "amount"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patient_payments_on_patient_id"
  end

  create_table "patient_receivables", force: :cascade do |t|
    t.integer "patient_file_id", null: false
    t.decimal "amount"
    t.boolean "is_paid", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "patient_id"
    t.string "description"
    t.integer "patient_payment_id"
    t.index ["patient_file_id"], name: "index_patient_receivables_on_patient_file_id"
    t.index ["patient_id"], name: "index_patient_receivables_on_patient_id"
    t.index ["patient_payment_id"], name: "index_patient_receivables_on_patient_payment_id"
  end

  create_table "patient_relatives", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.string "name"
    t.string "relationship"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.boolean "is_main", default: false
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patient_relatives_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.date "dob"
    t.boolean "is_active", default: true
    t.string "citizen_no"
    t.string "nif_no"
    t.string "health_no"
    t.string "social_security_no"
    t.string "clothes_tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sex"
    t.decimal "monthly_fee"
    t.decimal "balance"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 4
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.integer "user_id", null: false
    t.date "date"
    t.time "time"
    t.string "visitor_name"
    t.boolean "is_video", default: false
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_visits_on_patient_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "employee_admissions", "employees"
  add_foreign_key "employee_exits", "employee_admissions"
  add_foreign_key "employees", "users"
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
  add_foreign_key "patient_relatives", "patients"
  add_foreign_key "visits", "patients"
  add_foreign_key "visits", "users"
end

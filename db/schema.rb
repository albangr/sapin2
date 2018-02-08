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

ActiveRecord::Schema.define(version: 20180207095606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.integer "localisation"
    t.integer "firm_type"
    t.integer "employees_count"
    t.integer "turnover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prospect_id"
    t.string "firm_name"
    t.string "daughter_localisation"
    t.index ["prospect_id"], name: "index_companies_on_prospect_id"
  end

  create_table "obligations", force: :cascade do |t|
    t.string "title"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prospects", force: :cascade do |t|
    t.string "first_name"
    t.jsonb "address"
    t.string "phone_number"
    t.string "email"
    t.integer "role"
    t.boolean "is_responsible", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
  end

  create_table "report_obligation_tasks", force: :cascade do |t|
    t.bigint "report_obligation_id"
    t.bigint "task_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_obligation_id"], name: "index_report_obligation_tasks_on_report_obligation_id"
    t.index ["task_id"], name: "index_report_obligation_tasks_on_task_id"
  end

  create_table "report_obligations", force: :cascade do |t|
    t.bigint "report_id"
    t.bigint "obligation_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obligation_id"], name: "index_report_obligations_on_obligation_id"
    t.index ["report_id"], name: "index_report_obligations_on_report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.float "score"
    t.integer "result"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_reports_on_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.bigint "obligation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obligation_id"], name: "index_tasks_on_obligation_id"
  end

  add_foreign_key "report_obligation_tasks", "report_obligations"
  add_foreign_key "report_obligation_tasks", "tasks"
  add_foreign_key "report_obligations", "obligations"
  add_foreign_key "report_obligations", "reports"
  add_foreign_key "reports", "companies"
  add_foreign_key "tasks", "obligations"
end

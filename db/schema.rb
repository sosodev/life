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

ActiveRecord::Schema[8.0].define(version: 2025_05_29_140000) do
  create_table "task_lists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_task_lists_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "parent_id"
    t.integer "recur_after"
    t.integer "estimate"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_list_id", null: false
    t.datetime "started_at"
    t.boolean "urgent", default: false, null: false
    t.boolean "important", default: false, null: false
    t.date "due_date"
    t.datetime "scheduled_at"
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["task_list_id"], name: "index_tasks_on_task_list_id"
  end

  add_foreign_key "tasks", "task_lists"
  add_foreign_key "tasks", "tasks", column: "parent_id"
end

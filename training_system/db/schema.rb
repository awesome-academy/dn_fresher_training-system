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

ActiveRecord::Schema.define(version: 2021_08_12_070553) do

  create_table "course_subjects", charset: "utf8mb4", force: :cascade do |t|
    t.date "deadline"
    t.integer "status", default: 0
    t.bigint "course_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "courses", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "status", default: 0
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "subject_id", null: false
    t.index ["subject_id"], name: "index_tasks_on_subject_id"
  end

  create_table "user_course_subjects", charset: "utf8mb4", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "user_course_id", null: false
    t.bigint "course_subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["course_subject_id"], name: "index_user_course_subjects_on_course_subject_id"
    t.index ["user_course_id"], name: "index_user_course_subjects_on_user_course_id"
  end

  create_table "user_courses", charset: "utf8mb4", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_tasks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_course_subject_id", null: false
    t.bigint "task_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_course_subject_id"], name: "index_user_tasks_on_user_course_subject_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "roles", default: 0
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "course_subjects", "courses"
  add_foreign_key "course_subjects", "subjects"
  add_foreign_key "tasks", "subjects"
  add_foreign_key "user_course_subjects", "course_subjects"
  add_foreign_key "user_course_subjects", "user_courses"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "user_course_subjects"
end

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

ActiveRecord::Schema[7.2].define(version: 2025_02_14_143903) do
  create_table "race_entries", force: :cascade do |t|
    t.integer "race_id", null: false
    t.string "student_name", null: false
    t.integer "lane", null: false
    t.integer "final_place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id", "lane"], name: "index_race_entries_on_race_id_and_lane", unique: true
    t.index ["race_id", "student_name"], name: "index_race_entries_on_race_id_and_student_name", unique: true
    t.index ["race_id"], name: "index_race_entries_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "race_entries", "races", on_delete: :cascade
end

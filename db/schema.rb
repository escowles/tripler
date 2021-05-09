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

ActiveRecord::Schema.define(version: 2021_05_09_122507) do

  create_table "objs", force: :cascade do |t|
    t.integer "vocab_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vocab_id"], name: "index_objs_on_vocab_id"
  end

  create_table "predicates", force: :cascade do |t|
    t.string "name"
    t.integer "vocab_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vocab_id"], name: "index_predicates_on_vocab_id"
  end

  create_table "statements", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "predicate_id", null: false
    t.string "literal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["predicate_id"], name: "index_statements_on_predicate_id"
    t.index ["subject_id"], name: "index_statements_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "uri"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vocabs", force: :cascade do |t|
    t.string "prefix"
    t.string "uri"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "objs", "vocabs"
  add_foreign_key "predicates", "vocabs"
  add_foreign_key "statements", "predicates"
  add_foreign_key "statements", "subjects"
end

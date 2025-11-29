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

ActiveRecord::Schema[8.0].define(version: 2025_01_29_000003) do
  create_table "books", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "author", null: false
    t.text "description"
    t.string "isbn"
    t.string "publisher"
    t.date "published_date"
    t.integer "page_count"
    t.string "cover_url"
    t.string "google_books_id"
    t.integer "status", default: 0, null: false
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_books_on_status"
    t.index ["user_id", "google_books_id"], name: "index_books_on_user_id_and_google_books_id", unique: true, where: "google_books_id IS NOT NULL"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "readings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.text "note"
    t.text "review"
    t.integer "rating"
    t.date "started_at"
    t.date "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_readings_on_book_id"
    t.index ["rating"], name: "index_readings_on_rating"
    t.index ["user_id", "book_id"], name: "index_readings_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_readings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "users"
  add_foreign_key "readings", "books"
  add_foreign_key "readings", "users"
end

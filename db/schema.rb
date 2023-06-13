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

ActiveRecord::Schema[7.0].define(version: 2023_06_13_135446) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "book_in_bookcases", force: :cascade do |t|
    t.bigint "bookcase_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_in_bookcases_on_book_id"
    t.index ["bookcase_id"], name: "index_book_in_bookcases_on_bookcase_id"
  end

  create_table "bookcases", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookcases_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "page", null: false
    t.string "isbn"
    t.string "asin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "cognito_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "expire_time", null: false
    t.integer "issued_time", null: false
    t.string "audience", null: false
    t.text "refresh_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cognito_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "subscriber", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["subscriber"], name: "index_users_on_subscriber", unique: true
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "book_in_bookcases", "bookcases"
  add_foreign_key "book_in_bookcases", "books"
  add_foreign_key "bookcases", "users"
  add_foreign_key "cognito_sessions", "users"
end

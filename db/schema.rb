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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_121358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.bigint "cover_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["cover_id"], name: "index_bookings_on_cover_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "covers", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seats"
    t.index ["restaurant_id"], name: "index_covers_on_restaurant_id"
  end

  create_table "favourite_restaurants", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["restaurant_id"], name: "index_favourite_restaurants_on_restaurant_id"
    t.index ["user_id"], name: "index_favourite_restaurants_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.integer "rating"
    t.text "address"
    t.integer "total_seats_available"
    t.string "cuisine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "location"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "covers"
  add_foreign_key "bookings", "users"
  add_foreign_key "covers", "restaurants"
  add_foreign_key "favourite_restaurants", "restaurants"
  add_foreign_key "favourite_restaurants", "users"
end

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

ActiveRecord::Schema.define(version: 2019_09_08_220637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.date "startDate"
    t.date "endDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "albumstars", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_albumstars_on_album_id"
    t.index ["person_id"], name: "index_albumstars_on_person_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "address"], name: "index_locations_on_name_and_address", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["firstName", "lastName", "birthday"], name: "index_people_on_firstName_and_lastName_and_birthday", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.string "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.date "date"
    t.bigint "location_id"
    t.integer "user_id"
    t.index ["location_id"], name: "index_photos_on_location_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "photostars", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_photostars_on_person_id"
    t.index ["photo_id"], name: "index_photostars_on_photo_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "albumstars", "albums"
  add_foreign_key "albumstars", "people"
  add_foreign_key "photos", "locations"
  add_foreign_key "photostars", "people"
  add_foreign_key "photostars", "photos"
end

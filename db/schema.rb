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

ActiveRecord::Schema[7.0].define(version: 2022_06_18_200018) do
  create_table "activities", force: :cascade do |t|
    t.integer "strava_id"
    t.string "name"
    t.float "distance"
    t.string "moving_time"
    t.integer "elapsed_time"
    t.float "total_elevation_gain"
    t.float "elev_high"
    t.float "elev_low"
    t.float "average_speed"
    t.float "max_speed"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "athlete_id"
    t.index ["athlete_id"], name: "index_activities_on_athlete_id"
  end

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "strava_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polylines", force: :cascade do |t|
    t.integer "strava_id"
    t.text "polyline"
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_polylines_on_activity_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.integer "athlete_id", null: false
    t.string "token_type"
    t.string "access_token"
    t.integer "expires_in"
    t.integer "expires_at"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_tokens_on_athlete_id"
  end

  add_foreign_key "activities", "athletes"
  add_foreign_key "polylines", "activities"
  add_foreign_key "tokens", "athletes"
end

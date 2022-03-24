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

ActiveRecord::Schema.define(version: 2022_03_19_164717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicable_criteria", force: :cascade do |t|
    t.bigint "criteria_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "division_id", null: false
    t.index ["criteria_type_id"], name: "index_applicable_criteria_on_criteria_type_id"
    t.index ["division_id"], name: "index_applicable_criteria_on_division_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.text "description"
    t.bigint "criteria_type_id", null: false
    t.integer "suggested_score"
    t.boolean "optional"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "division_id", null: false
    t.index ["criteria_type_id"], name: "index_criteria_on_criteria_type_id"
    t.index ["division_id"], name: "index_criteria_on_division_id"
  end

  create_table "criteria_descriptions", force: :cascade do |t|
    t.text "description"
    t.bigint "criteria_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "division_id", null: false
    t.index ["criteria_type_id"], name: "index_criteria_descriptions_on_criteria_type_id"
    t.index ["division_id"], name: "index_criteria_descriptions_on_division_id"
  end

  create_table "criteria_types", force: :cascade do |t|
    t.string "description"
    t.integer "max_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "criteria_type_id"
    t.bigint "parent_id"
    t.index ["criteria_type_id"], name: "index_criteria_types_on_criteria_type_id"
    t.index ["parent_id"], name: "index_criteria_types_on_parent_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
  end

  create_table "entries", force: :cascade do |t|
    t.string "entry_name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "timeslot_id"
    t.boolean "in_person", default: true
    t.boolean "scored", default: true
    t.text "materials"
    t.string "culture"
    t.string "time_period"
    t.boolean "pentathlon", default: false
    t.boolean "division_type", default: false
    t.boolean "first_time", default: false
    t.boolean "youth", default: false
    t.bigint "fair_id", null: false
    t.bigint "location_id"
    t.bigint "prior_entry_id"
    t.bigint "division_id", null: false
    t.index ["division_id"], name: "index_entries_on_division_id"
    t.index ["fair_id"], name: "index_entries_on_fair_id"
    t.index ["location_id"], name: "index_entries_on_location_id"
    t.index ["prior_entry_id"], name: "index_entries_on_prior_entry_id"
    t.index ["timeslot_id"], name: "index_entries_on_timeslot_id"
  end

  create_table "fairs", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "region_id", null: false
    t.string "name"
    t.boolean "internet_access", default: true
    t.text "comment"
    t.boolean "entries_allowed", default: false
    t.boolean "scheduling_visible", default: false
    t.boolean "scoresheets_allowed", default: false
    t.boolean "mail_in_scoresheets_allowed", default: false
    t.boolean "finalized", default: false
    t.boolean "kingdom", default: false
    t.index ["region_id"], name: "index_fairs_on_region_id"
  end

  create_table "judge_assigns", force: :cascade do |t|
    t.boolean "assigned"
    t.boolean "shadow"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "entry_id", null: false
    t.index ["entry_id"], name: "index_judge_assigns_on_entry_id"
    t.index ["user_id"], name: "index_judge_assigns_on_user_id"
  end

  create_table "judge_fairs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "fair_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "shadow_judge", default: false
    t.boolean "first_time", default: false
    t.index ["fair_id"], name: "index_judge_fairs_on_fair_id"
    t.index ["user_id"], name: "index_judge_fairs_on_user_id"
  end

  create_table "judge_preferences", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "division_id", null: false
    t.index ["division_id"], name: "index_judge_preferences_on_division_id"
    t.index ["user_id"], name: "index_judge_preferences_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "description"
    t.bigint "fair_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fair_id"], name: "index_locations_on_fair_id"
  end

  create_table "peerages", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "criteria_type_id", null: false
    t.text "comment"
    t.decimal "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "scoresheet_id", null: false
    t.index ["criteria_type_id"], name: "index_scores_on_criteria_type_id"
    t.index ["scoresheet_id"], name: "index_scores_on_scoresheet_id"
  end

  create_table "scoresheets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "entry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entry_id"], name: "index_scoresheets_on_entry_id"
    t.index ["user_id"], name: "index_scoresheets_on_user_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.integer "order"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_entries", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "entry_id", null: false
    t.index ["entry_id"], name: "index_user_entries_on_entry_id"
    t.index ["user_id"], name: "index_user_entries_on_user_id"
  end

  create_table "user_peerages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "peerage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["peerage_id"], name: "index_user_peerages_on_peerage_id"
    t.index ["user_id"], name: "index_user_peerages_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_role_id", null: false
    t.bigint "region_id", null: false
    t.boolean "written", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "sca_name"
    t.string "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["region_id"], name: "index_users_on_region_id"
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  add_foreign_key "applicable_criteria", "criteria_types"
  add_foreign_key "applicable_criteria", "divisions"
  add_foreign_key "criteria", "criteria_types"
  add_foreign_key "criteria", "divisions"
  add_foreign_key "criteria_descriptions", "criteria_types"
  add_foreign_key "criteria_descriptions", "divisions"
  add_foreign_key "entries", "divisions"
  add_foreign_key "entries", "fairs"
  add_foreign_key "entries", "locations"
  add_foreign_key "entries", "timeslots"
  add_foreign_key "fairs", "regions"
  add_foreign_key "judge_assigns", "entries"
  add_foreign_key "judge_assigns", "users"
  add_foreign_key "judge_fairs", "fairs"
  add_foreign_key "judge_fairs", "users"
  add_foreign_key "judge_preferences", "divisions"
  add_foreign_key "judge_preferences", "users"
  add_foreign_key "locations", "fairs"
  add_foreign_key "scores", "criteria_types"
  add_foreign_key "scores", "scoresheets"
  add_foreign_key "scoresheets", "entries"
  add_foreign_key "scoresheets", "users"
  add_foreign_key "user_entries", "entries"
  add_foreign_key "user_entries", "users"
  add_foreign_key "user_peerages", "peerages"
  add_foreign_key "user_peerages", "users"
  add_foreign_key "users", "regions"
  add_foreign_key "users", "user_roles"
end

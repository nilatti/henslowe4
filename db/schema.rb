# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160205025841) do

  create_table "acts", force: :cascade do |t|
    t.integer  "act_number", limit: 4
    t.integer  "play_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "acts", ["play_id"], name: "index_acts_on_play_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.date     "birth_date"
    t.date     "death_date"
    t.text     "bio",        limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age",        limit: 4
    t.boolean  "is_female"
    t.integer  "play_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "characters", ["play_id"], name: "index_characters_on_play_id", using: :btree

  create_table "french_scenes", force: :cascade do |t|
    t.string   "french_scene_number", limit: 255
    t.integer  "scene_id",            limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "french_scenes", ["scene_id"], name: "index_french_scenes_on_scene_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "specialization_id", limit: 4
    t.integer  "production_id",     limit: 4
    t.integer  "theater_id",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "jobs", ["production_id"], name: "index_jobs_on_production_id", using: :btree
  add_index "jobs", ["specialization_id"], name: "index_jobs_on_specialization_id", using: :btree
  add_index "jobs", ["theater_id"], name: "index_jobs_on_theater_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "on_stages", force: :cascade do |t|
    t.integer  "character_id",    limit: 4
    t.integer  "french_scene_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "on_stages", ["character_id"], name: "index_on_stages_on_character_id", using: :btree
  add_index "on_stages", ["french_scene_id"], name: "index_on_stages_on_french_scene_id", using: :btree

  create_table "plays", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.date     "date"
    t.integer  "author_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "plays", ["author_id"], name: "index_plays_on_author_id", using: :btree

  create_table "productions", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "play_id",    limit: 4
    t.integer  "theater_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "productions", ["play_id"], name: "index_productions_on_play_id", using: :btree
  add_index "productions", ["theater_id"], name: "index_productions_on_theater_id", using: :btree

  create_table "rehearsals", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "act_id",          limit: 4
    t.integer  "scene_id",        limit: 4
    t.integer  "french_scene_id", limit: 4
    t.integer  "space_id",        limit: 4
    t.integer  "production_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "rehearsals", ["act_id"], name: "index_rehearsals_on_act_id", using: :btree
  add_index "rehearsals", ["french_scene_id"], name: "index_rehearsals_on_french_scene_id", using: :btree
  add_index "rehearsals", ["production_id"], name: "index_rehearsals_on_production_id", using: :btree
  add_index "rehearsals", ["scene_id"], name: "index_rehearsals_on_scene_id", using: :btree
  add_index "rehearsals", ["space_id"], name: "index_rehearsals_on_space_id", using: :btree

  create_table "scenes", force: :cascade do |t|
    t.integer  "scene_number", limit: 4
    t.integer  "play_id",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "act_id",       limit: 4
  end

  add_index "scenes", ["play_id"], name: "index_scenes_on_play_id", using: :btree

  create_table "spaces", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "street_address",   limit: 255
    t.string   "city",             limit: 255
    t.string   "state",            limit: 255
    t.string   "zip",              limit: 255
    t.string   "phone_number",     limit: 255
    t.string   "website",          limit: 255
    t.integer  "seating_capacity", limit: 4
    t.string   "calendar",         limit: 255
    t.integer  "theater_id",       limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "spaces", ["theater_id"], name: "index_spaces_on_theater_id", using: :btree

  create_table "specializations", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "street_address",    limit: 255
    t.string   "city",              limit: 255
    t.string   "state",             limit: 255
    t.string   "zip",               limit: 255
    t.string   "phone_number",      limit: 255
    t.text     "mission_statement", limit: 65535
    t.string   "website",           limit: 255
    t.string   "calendar",          limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "characters", "plays"
  add_foreign_key "french_scenes", "scenes"
  add_foreign_key "jobs", "productions"
  add_foreign_key "jobs", "specializations"
  add_foreign_key "jobs", "theaters"
  add_foreign_key "jobs", "users"
  add_foreign_key "on_stages", "characters"
  add_foreign_key "on_stages", "french_scenes"
  add_foreign_key "plays", "authors"
  add_foreign_key "productions", "plays"
  add_foreign_key "productions", "theaters"
  add_foreign_key "rehearsals", "acts"
  add_foreign_key "rehearsals", "french_scenes"
  add_foreign_key "rehearsals", "productions"
  add_foreign_key "rehearsals", "scenes"
  add_foreign_key "rehearsals", "spaces"
  add_foreign_key "scenes", "plays"
  add_foreign_key "spaces", "theaters"
end

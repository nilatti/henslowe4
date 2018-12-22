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

ActiveRecord::Schema.define(version: 20181219182858) do

  create_table "acts", force: :cascade do |t|
    t.integer  "act_number", limit: 4
    t.integer  "play_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "summary",    limit: 65535
    t.integer  "start_page", limit: 4
    t.integer  "end_page",   limit: 4
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
    t.string   "name",        limit: 255
    t.string   "age",         limit: 255
    t.string   "gender",      limit: 255
    t.integer  "play_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
    t.string   "xml_id",      limit: 255
    t.string   "group_id",    limit: 255
  end

  add_index "characters", ["play_id"], name: "index_characters_on_play_id", using: :btree

  create_table "conflicts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "category",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "space_id",   limit: 4
  end

  add_index "conflicts", ["space_id"], name: "index_conflicts_on_space_id", using: :btree
  add_index "conflicts", ["user_id"], name: "index_conflicts_on_user_id", using: :btree

  create_table "default_rehearsal_attendees", force: :cascade do |t|
    t.integer  "rehearsal_schedule_id", limit: 4
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "default_rehearsal_attendees", ["rehearsal_schedule_id"], name: "index_default_rehearsal_attendees_on_rehearsal_schedule_id", using: :btree
  add_index "default_rehearsal_attendees", ["user_id"], name: "index_default_rehearsal_attendees_on_user_id", using: :btree

  create_table "extras", force: :cascade do |t|
    t.integer  "french_scene_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "name",            limit: 255
    t.boolean  "needs_costume"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "extras", ["french_scene_id"], name: "index_extras_on_french_scene_id", using: :btree
  add_index "extras", ["user_id"], name: "index_extras_on_user_id", using: :btree

  create_table "french_scenes", force: :cascade do |t|
    t.string   "french_scene_number", limit: 255
    t.integer  "scene_id",            limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "start_page",          limit: 4
    t.integer  "end_page",            limit: 4
  end

  add_index "french_scenes", ["scene_id"], name: "index_french_scenes_on_scene_id", using: :btree

  create_table "french_scenes_rehearsals", force: :cascade do |t|
    t.integer  "rehearsal_id",    limit: 4
    t.integer  "french_scene_id", limit: 4
    t.string   "process",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "french_scenes_rehearsals", ["french_scene_id"], name: "index_french_scenes_rehearsals_on_french_scene_id", using: :btree
  add_index "french_scenes_rehearsals", ["rehearsal_id"], name: "index_french_scenes_rehearsals_on_rehearsal_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "specialization_id", limit: 4
    t.integer  "production_id",     limit: 4
    t.integer  "theater_id",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "character_id",      limit: 4
  end

  add_index "jobs", ["production_id"], name: "index_jobs_on_production_id", using: :btree
  add_index "jobs", ["specialization_id"], name: "index_jobs_on_specialization_id", using: :btree
  add_index "jobs", ["theater_id"], name: "index_jobs_on_theater_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "lines", force: :cascade do |t|
    t.string   "text",            limit: 255
    t.integer  "french_scene_id", limit: 4
    t.integer  "character_id",    limit: 4
    t.string   "category",        limit: 255
    t.boolean  "cut"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "line_number",     limit: 255
  end

  create_table "on_stages", force: :cascade do |t|
    t.integer  "character_id",    limit: 4
    t.integer  "french_scene_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "nonspeaking"
  end

  add_index "on_stages", ["character_id"], name: "index_on_stages_on_character_id", using: :btree
  add_index "on_stages", ["french_scene_id"], name: "index_on_stages_on_french_scene_id", using: :btree

  create_table "plays", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.date     "date"
    t.integer  "author_id",           limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "canonical"
    t.text     "summary",             limit: 65535
    t.text     "text_notes",          limit: 65535
    t.integer  "production_id",       limit: 4
    t.string   "script_file_name",    limit: 255
    t.string   "script_content_type", limit: 255
    t.integer  "script_file_size",    limit: 4
    t.datetime "script_updated_at"
    t.integer  "start_page",          limit: 4
    t.integer  "end_page",            limit: 4
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

  create_table "rehearsal_calls", force: :cascade do |t|
    t.integer  "rehearsal_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "rehearsal_calls", ["rehearsal_id"], name: "index_rehearsal_calls_on_rehearsal_id", using: :btree
  add_index "rehearsal_calls", ["user_id"], name: "index_rehearsal_calls_on_user_id", using: :btree

  create_table "rehearsal_materials", force: :cascade do |t|
    t.integer  "rehearsal_id",    limit: 4
    t.integer  "play_id",         limit: 4
    t.integer  "act_id",          limit: 4
    t.integer  "scene_id",        limit: 4
    t.integer  "french_scene_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "rehearsal_materials", ["act_id"], name: "index_rehearsal_materials_on_act_id", using: :btree
  add_index "rehearsal_materials", ["french_scene_id"], name: "index_rehearsal_materials_on_french_scene_id", using: :btree
  add_index "rehearsal_materials", ["play_id"], name: "index_rehearsal_materials_on_play_id", using: :btree
  add_index "rehearsal_materials", ["rehearsal_id"], name: "index_rehearsal_materials_on_rehearsal_id", using: :btree
  add_index "rehearsal_materials", ["scene_id"], name: "index_rehearsal_materials_on_scene_id", using: :btree

  create_table "rehearsal_schedules", force: :cascade do |t|
    t.integer  "production_id", limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "interval",      limit: 255
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "space_id",      limit: 4
  end

  add_index "rehearsal_schedules", ["production_id"], name: "index_rehearsal_schedules_on_production_id", using: :btree
  add_index "rehearsal_schedules", ["space_id"], name: "index_rehearsal_schedules_on_space_id", using: :btree

  create_table "rehearsals", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "space_id",              limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "rehearsal_schedule_id", limit: 4
    t.text     "notes",                 limit: 65535
    t.string   "title",                 limit: 255
  end

  add_index "rehearsals", ["rehearsal_schedule_id"], name: "fk_rails_95eeb33c76", using: :btree
  add_index "rehearsals", ["space_id"], name: "index_rehearsals_on_space_id", using: :btree

  create_table "scenes", force: :cascade do |t|
    t.integer  "scene_number", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "act_id",       limit: 4
    t.text     "summary",      limit: 65535
    t.integer  "start_page",   limit: 4
    t.integer  "end_page",     limit: 4
  end

  create_table "space_agreements", force: :cascade do |t|
    t.integer  "theater_id", limit: 4
    t.integer  "space_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "space_agreements", ["space_id"], name: "index_space_agreements_on_space_id", using: :btree
  add_index "space_agreements", ["theater_id"], name: "index_space_agreements_on_theater_id", using: :btree

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
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "description",      limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "production_admin"
    t.boolean  "theater_admin"
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
    t.string   "email",                  limit: 255, default: "",        null: false
    t.string   "encrypted_password",     limit: 255, default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "first_name",             limit: 255
    t.string   "role",                   limit: 255, default: "regular"
    t.string   "last_name",              limit: 255
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "characters", "plays"
  add_foreign_key "conflicts", "spaces"
  add_foreign_key "conflicts", "users"
  add_foreign_key "default_rehearsal_attendees", "rehearsal_schedules"
  add_foreign_key "default_rehearsal_attendees", "users"
  add_foreign_key "extras", "french_scenes"
  add_foreign_key "extras", "users"
  add_foreign_key "french_scenes", "scenes"
  add_foreign_key "french_scenes_rehearsals", "french_scenes"
  add_foreign_key "french_scenes_rehearsals", "rehearsals"
  add_foreign_key "jobs", "productions"
  add_foreign_key "jobs", "specializations"
  add_foreign_key "jobs", "theaters"
  add_foreign_key "jobs", "users"
  add_foreign_key "on_stages", "characters"
  add_foreign_key "on_stages", "french_scenes"
  add_foreign_key "plays", "authors"
  add_foreign_key "productions", "plays"
  add_foreign_key "productions", "theaters"
  add_foreign_key "rehearsal_calls", "rehearsals"
  add_foreign_key "rehearsal_calls", "users"
  add_foreign_key "rehearsal_materials", "acts"
  add_foreign_key "rehearsal_materials", "french_scenes"
  add_foreign_key "rehearsal_materials", "plays"
  add_foreign_key "rehearsal_materials", "rehearsals"
  add_foreign_key "rehearsal_materials", "scenes"
  add_foreign_key "rehearsal_schedules", "productions"
  add_foreign_key "rehearsal_schedules", "spaces"
  add_foreign_key "rehearsals", "rehearsal_schedules"
  add_foreign_key "rehearsals", "spaces"
  add_foreign_key "space_agreements", "spaces"
  add_foreign_key "space_agreements", "theaters"
end

FactoryGirl.define do
	factory :rehearsal_schedule do
    production
    start_date: Date.today
    end_date: Date.today + 3.months
    # create_table "rehearsal_schedules", force: :cascade do |t|
    #   t.integer  "production_id", limit: 4
    #   t.date     "start_date"
    #   t.date     "end_date"
    #   t.datetime "start_time"
    #   t.datetime "end_time"
    #   t.string   "interval",      limit: 255
    #   t.boolean  "sunday"
    #   t.boolean  "monday"
    #   t.boolean  "tuesday"
    #   t.boolean  "wednesday"
    #   t.boolean  "thursday"
    #   t.boolean  "friday"
    #   t.boolean  "saturday"
    #   t.datetime "created_at",                null: false
    #   t.datetime "updated_at",                null: false
    #   t.integer  "space_id",      limit: 4
    # end
	end
end

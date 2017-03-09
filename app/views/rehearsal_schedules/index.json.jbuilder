json.array!(@rehearsal_schedules) do |rehearsal_schedule|
  json.extract! rehearsal_schedule, :id, :production_id, :start_date, :end_date, :start_time, :end_time, :interval, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  json.url rehearsal_schedule_url(rehearsal_schedule, format: :json)
end

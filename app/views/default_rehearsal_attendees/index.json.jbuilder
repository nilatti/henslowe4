json.array!(@default_rehearsal_attendees) do |default_rehearsal_attendee|
  json.extract! default_rehearsal_attendee, :id, :rehearsal_schedule_id, :user_id
  json.url default_rehearsal_attendee_url(default_rehearsal_attendee, format: :json)
end

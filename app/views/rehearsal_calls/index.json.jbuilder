json.array!(@rehearsal_calls) do |rehearsal_call|
  json.extract! rehearsal_call, :id, :rehearsal_id, :user_id
  json.url rehearsal_call_url(rehearsal_call, format: :json)
end

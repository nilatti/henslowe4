json.array!(@conflicts) do |conflict|
  json.extract! conflict, :id, :user_id, :start, :end, :type
  json.url conflict_url(conflict, format: :json)
end

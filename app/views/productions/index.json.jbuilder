json.array!(@productions) do |production|
  json.extract! production, :id, :start_date, :end_date, :play_id, :theater_id
  json.url production_url(production, format: :json)
end

json.array!(@theaters) do |theater|
  json.extract! theater, :id, :name, :street_address, :city, :state, :zip, :phone_number, :mission_statement, :website, :calendar
  json.url theater_url(theater, format: :json)
end

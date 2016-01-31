json.array!(@spaces) do |space|
  json.extract! space, :id, :name, :street_address, :city, :state, :zip, :phone_number, :website, :seating_capacity, :calendar, :theater_id
  json.url space_url(space, format: :json)
end

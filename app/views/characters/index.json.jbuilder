json.array!(@characters) do |character|
  json.extract! character, :id, :name, :age, :is_female, :play_id
  json.url character_url(character, format: :json)
end

json.array!(@specializations) do |specialization|
  json.extract! specialization, :id, :title, :description
  json.url specialization_url(specialization, format: :json)
end

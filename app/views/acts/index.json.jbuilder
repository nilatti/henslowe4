json.array!(@acts) do |act|
  json.extract! act, :id, :act_number, :play_id
  json.url act_url(act, format: :json)
end

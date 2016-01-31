json.array!(@scenes) do |scene|
  json.extract! scene, :id, :scene_number, :play_id
  json.url scene_url(scene, format: :json)
end

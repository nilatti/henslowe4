json.array!(@french_scenes) do |french_scene|
  json.extract! french_scene, :id, :french_scene_number, :scene_id
  json.url french_scene_url(french_scene, format: :json)
end

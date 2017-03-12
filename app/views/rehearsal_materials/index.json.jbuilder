json.array!(@rehearsal_materials) do |rehearsal_material|
  json.extract! rehearsal_material, :id, :rehearsal_id, :play_id, :act_id, :scene_id, :french_scene_id
  json.url rehearsal_material_url(rehearsal_material, format: :json)
end

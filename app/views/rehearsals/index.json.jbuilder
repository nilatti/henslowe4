json.array!(@rehearsals) do |rehearsal|
  json.extract! rehearsal, :id, :start_time, :end_time, :act_id, :scene_id, :french_scene_id, :space_id, :production_id
  json.url rehearsal_url(rehearsal, format: :json)
end

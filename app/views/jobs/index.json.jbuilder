json.array!(@jobs) do |job|
  json.extract! job, :id, :user_id, :specialization_id, :production_id, :theater_id
  json.url job_url(job, format: :json)
end

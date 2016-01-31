json.array!(@plays) do |play|
  json.extract! play, :id, :title, :date, :author_id
  json.url play_url(play, format: :json)
end

json.array!(@lines) do |line|
  json.extract! line, :id, :text, :belongs_to, :belongs_to, :type, :cut
  json.url line_url(line, format: :json)
end

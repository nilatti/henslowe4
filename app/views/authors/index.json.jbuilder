json.array!(@authors) do |author|
  json.extract! author, :id, :first_name, :last_name, :birth_date, :death_date, :bio
  json.url author_url(author, format: :json)
end

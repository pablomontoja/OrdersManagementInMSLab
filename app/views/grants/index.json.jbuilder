json.array!(@grants) do |grant|
  json.extract! grant, :id, :name, :short_name
  json.url grant_url(grant, format: :json)
end

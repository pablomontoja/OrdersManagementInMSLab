json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name, :short_name, :address_line1, :address_line2
  json.url institution_url(institution, format: :json)
end

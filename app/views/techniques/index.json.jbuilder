json.array!(@techniques) do |technique|
  json.extract! technique, :id, :name, :short_name, :price_icho, :price_ncc, :price_cc, :price_science
  json.url technique_url(technique, format: :json)
end

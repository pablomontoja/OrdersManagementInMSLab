json.array!(@measurements) do |measurement|
  json.extract! measurement, :id, :multiplier, :price, :measurement_by, :measurement_at, :comment
  json.url measurement_url(measurement, format: :json)
end

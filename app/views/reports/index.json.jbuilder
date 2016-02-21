json.array!(@reports) do |report|
  json.extract! report, :id, :name, :date_from, :date_to, :institution, :team, :client, :grant
  json.url report_url(report, format: :json)
end

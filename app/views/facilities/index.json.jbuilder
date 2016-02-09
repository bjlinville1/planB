json.array!(@facilities) do |facility|
  json.extract! facility, :id
  json.url facility_url(facility, format: :json)
end

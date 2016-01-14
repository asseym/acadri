json.array!(@program_venues) do |program_venue|
  json.extract! program_venue, :id, :name, :country_id
  json.url program_venue_url(program_venue, format: :json)
end

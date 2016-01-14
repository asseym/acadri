json.array!(@profiles) do |profile|
  json.extract! profile, :id, :section_name
  json.url profile_url(profile, format: :json)
end

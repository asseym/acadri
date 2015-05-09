json.array!(@countries) do |country|
  json.extract! country, :id, :name, :c_code, :telephone_code
  json.url country_url(country, format: :json)
end

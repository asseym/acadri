json.array!(@assets) do |asset|
  json.extract! asset, :id, :name, :description, :asset_category, :current_value, :country_id
  json.url asset_url(asset, format: :json)
end

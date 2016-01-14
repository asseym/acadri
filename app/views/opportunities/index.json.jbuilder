json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :title, :description, :opportunity_status_id, :user_id
  json.url opportunity_url(opportunity, format: :json)
end

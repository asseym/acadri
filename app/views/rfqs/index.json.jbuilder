json.array!(@rfqs) do |rfq|
  json.extract! rfq, :id, :rfq_id, :action, :rfq_date, :due_date, :issuer, :description, :users_id
  json.url rfq_url(rfq, format: :json)
end

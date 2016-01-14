json.array!(@notifications) do |notification|
  json.extract! notification, :id, :notification
  json.url notification_url(notification, format: :json)
end

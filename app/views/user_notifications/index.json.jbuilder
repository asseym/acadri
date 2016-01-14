json.array!(@user_notifications) do |user_notification|
  json.extract! user_notification, :id, :notification_id, :user_id, :resolved
  json.url user_notification_url(user_notification, format: :json)
end

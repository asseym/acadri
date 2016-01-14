class UserObserver < ActiveRecord::Observer
  
  #Every new user created triggers a notification
  def after_create(user)
    n = Notification.create!(notification:'New User #{user.name} Created')
    UserNotification.create(notification: n, user: User.current_user)
  end
  
end
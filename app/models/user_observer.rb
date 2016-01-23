class UserObserver < ActiveRecord::Observer
  
  #Every new user created triggers a notification
  def after_create(user)
    user.create_notification
  end
  
end
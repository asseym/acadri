class OpportunityObserver < ActiveRecord::Observer
  
  #Every new opportunity triggers a notification
  def after_create(opportunity)
    if opportunity.opportunity_status.name == "New"
      n = Notification.create!(notification:'New Opportunity Created')
      UserNotification.create(notification: n, user: User.find(opportunity.user_id))
    end
  end
  
  #Won opportunities trigger a prompt to invoice
  def after_update(opportunity)
    if opportunity.opportunity_status.name == "Won"
      n = Notification.create!(notification: "#{opportunity.id}")
      UserNotification.create(notification: n, user: User.find(opportunity.user_id))
    end
  end
end
class OpportunityObserver < ActiveRecord::Observer
  
  #Every new opportunity triggers a notification
  def after_create(opportunity)
    opportunity.create_notification
  end
  
  #Won opportunities trigger a prompt to invoice
  def after_update(opportunity)
    opportunity.update_notification
  end
end
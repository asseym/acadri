require 'rails_helper'

RSpec.describe OpportunityObserver do
  before :each do
    @opportunity = stub_model Opportunity
    @user = stub_model User, :roles => [:admin]
    @notification = stub_model Notification
    @observer = OpportunityObserver.instance
  end

  it "invokes after_create on Opportunity object" do
    expect(@opportunity).to receive(:create_notification)
    @observer.after_create(@opportunity)
  end

  it "invokes after_update on Opportunity object" do
    @opportunity_status = stub_model OpportunityStatus, :name => "Won"
    @opportunity.opportunity_status = @opportunity_status
    @opportunity.save
    expect(@opportunity).to receive(:update_notification)
    @observer.after_update(@opportunity)
  end
end

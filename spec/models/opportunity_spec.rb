require 'rails_helper'

RSpec.describe Opportunity, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:opportunity)).to be_valid
  end

  it "has a valid factory with new opportunity status" do
    expect(FactoryGirl.create(:opportunity_with_new_status)).to be_valid
    expect(FactoryGirl.create(:opportunity_with_new_status).opportunity_status.name).to match "New"
  end

  it "has a valid factory with won opportunity status" do
    expect(FactoryGirl.create(:opportunity_with_won_status)).to be_valid
    expect(FactoryGirl.create(:opportunity_with_won_status).opportunity_status.name).to match "Won"
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:opportunity, title: nil)).to be_invalid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:opportunity, description: nil)).to be_invalid
  end

  it "is invalid without an opportunity status" do
    expect(FactoryGirl.build(:opportunity, opportunity_status: nil)).to be_invalid
  end

  it "is invalid without user" do
    expect(FactoryGirl.build(:opportunity, user: nil)).to be_invalid
  end

  it "is valid without an attachment" do
    expect(FactoryGirl.build(:opportunity, attachment: nil)).to be_valid
  end

  it "returns a title when to_s is called on object" do
    expect(FactoryGirl.create(:opportunity, title: 'my opportunity').to_s).to match 'my opportunity'
  end

  describe "Observer functionality" do
    before :each do
      @admin_user = FactoryGirl.create(:admin_user, name: 'admin')
      @program_coordinator = FactoryGirl.create(:program_coordinator_user, name: 'pc')
      UserNotification.delete_all #clean up notifications
      @opportunity = FactoryGirl.create(:opportunity_with_new_status)
    end

    it "creates notifications on save" do
      expect(UserNotification.count).to eq(3)
    end

    it "creates notification on update" do
      @opportunity.opportunity_status = FactoryGirl.create(:opportunity_status_won)
      @opportunity.save
      expect(UserNotification.count).to eq(5)
    end

  end
end

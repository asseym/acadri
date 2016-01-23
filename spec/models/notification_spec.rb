require 'rails_helper'

RSpec.describe Notification, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:notification)).to be_valid
  end

  it "saves receipients" do
    expect(FactoryGirl.create(:notification_with_users)).to be_valid
  end

  it "is invalid without a notification" do
    expect(FactoryGirl.build(:notification, notification: nil)).to be_invalid
  end

  it "returns list of its receipients" do
    expect(FactoryGirl.create(:notification_with_users).receipients).to include(be_a_kind_of User)
  end

  it "returns text notification" do
    expect(FactoryGirl.create(:notification).to_s).to be_a_kind_of String
  end

end

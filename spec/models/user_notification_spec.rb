require 'rails_helper'

RSpec.describe UserNotification, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user_notification)).to be_valid
  end
end

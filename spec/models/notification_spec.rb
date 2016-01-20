require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:notification)).to be_valid
  end
end

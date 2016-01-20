require 'rails_helper'

RSpec.describe OpportunityStatus, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:opportunity_status)).to be_valid
  end
end

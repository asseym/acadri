require 'rails_helper'

RSpec.describe OpportunityStatus, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:opportunity_status)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:opportunity_status, name: nil)).to be_invalid
  end

  it "returns name" do
    expect(FactoryGirl.create(:opportunity_status, name:'proposal').to_s).to match 'proposal'
  end

end

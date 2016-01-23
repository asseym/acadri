require 'rails_helper'

RSpec.describe ProgramVenue, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program_venue)).to be_valid
  end

  it "is invalid without place/city" do
    expect(FactoryGirl.build(:program_venue, name:nil)).to be_invalid
  end

  it "is invalid without a country" do
    expect(FactoryGirl.build(:program_venue, country:nil)).to be_invalid
  end

  it "returns hash of place and country" do
    expect(FactoryGirl.create(:program_venue).to_s).to be_a_kind_of Hash
  end
end

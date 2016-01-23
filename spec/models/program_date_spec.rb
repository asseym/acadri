require 'rails_helper'

RSpec.describe ProgramDate, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program_date)).to be_valid
  end

  it "is invalid without a start date" do
    expect(FactoryGirl.build(:program_date, start_date:nil)).to be_invalid
  end

  it "is invalid without an end date" do
    expect(FactoryGirl.build(:program_date, end_date:nil)).to be_invalid
  end

  it "returns hash of start and end date" do
    expect(FactoryGirl.create(:program_date).to_s).to be_a_kind_of Hash
  end

end

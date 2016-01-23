require 'rails_helper'

RSpec.describe Program, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end

  it "has a valid factory with dates and venues" do
    expect(FactoryGirl.create(:program_with_dates_and_venues)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:program, name: nil)).to be_invalid
  end

  it "is invalid without category" do
    expect(FactoryGirl.build(:program, category: nil)).to be_invalid
  end

  it "is invalid without is_service" do
    expect(FactoryGirl.build(:program, is_service: nil)).to be_invalid
  end

  it "returns name" do
    expect(FactoryGirl.create(:program, name: 'Secretarial').to_s).to match 'Secretarial'
  end

  it "returns dates" do
    expect(FactoryGirl.create(:program_with_dates_and_venues).dates).to_not be_empty
  end

  it "returns venues" do
    expect(FactoryGirl.create(:program_with_dates_and_venues).venues).to_not be_empty
  end


end

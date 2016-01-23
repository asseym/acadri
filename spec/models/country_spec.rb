require 'rails_helper'

RSpec.describe Country, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:country)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:country, name: nil)).to be_invalid
  end

  it "is valid without a country code" do
    expect(FactoryGirl.build(:country, c_code: nil)).to be_valid
  end

  it "is valid without a country telephone code" do
    expect(FactoryGirl.build(:country, telephone_code: nil)).to be_invalid
  end

  it "is invalid with non integer telephone code" do
    expect(FactoryGirl.build(:country, telephone_code: 'somerubish')).to be_invalid
  end

  it "returns name when to_s function is called on object" do
    expect(FactoryGirl.create(:country).to_s).to be_a_kind_of String
  end

end

require 'rails_helper'

RSpec.describe ProfileBankDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_bank_detail)).to be_valid
  end

  it "is invalid without bank details" do
    expect(FactoryGirl.build(:profile_bank_detail, bank_details: nil)).to be_invalid
  end

  # it "is invalid without a user" do
  #   expect(FactoryGirl.build(:profile_bank_detail, user: nil)).to be_invalid
  # end

  it "is invalid without a profile section" do
    expect(FactoryGirl.build(:profile_bank_detail, profile: nil)).to be_invalid
  end

  it "returns bank details text" do
    expect(FactoryGirl.create(:profile_bank_detail, bank_details: 'Standard Chartered').to_s).to match 'Standard Chartered'
  end
end

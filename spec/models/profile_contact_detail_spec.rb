require 'rails_helper'

RSpec.describe ProfileContactDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_contact_detail)).to be_valid
  end

  # it "is invalid without a user" do
  #   expect(FactoryGirl.build(:profile_contact_detail, user: nil)).to be_invalid
  # end

  it "is invalid without a profile" do
    expect(FactoryGirl.build(:profile_contact_detail, profile: nil)).to be_invalid
  end

  it "is invalid without an address" do
    expect(FactoryGirl.build(:profile_contact_detail, address: nil)).to be_invalid
  end

  it "is invalid without an email address" do
    expect(FactoryGirl.build(:profile_contact_detail, email_address: nil)).to be_invalid
  end

  it "is invalid bad email address" do
    expect(FactoryGirl.build(:profile_contact_detail, email_address: 'funnyAddress')).to be_invalid
  end

  it "is invalid without mobile phone" do
    expect(FactoryGirl.build(:profile_contact_detail, mobile_phone: nil)).to be_invalid
  end

end

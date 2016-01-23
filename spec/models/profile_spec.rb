require 'rails_helper'

RSpec.describe Profile, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile)).to be_valid
  end

  it "is invalid without a section name" do
    expect(FactoryGirl.build(:profile, section_name: nil)).to be_invalid
  end

  it "has a valid factory with personal profile details" do
    expect(FactoryGirl.create(:profile_with_personal_details)).to be_valid
    expect(FactoryGirl.create(:profile_with_personal_details).section_name).to match 'Personal Details'
  end

  it "has a valid factory with general profile details" do
    expect(FactoryGirl.create(:profile_with_general_details)).to be_valid
    expect(FactoryGirl.create(:profile_with_general_details).section_name).to match 'General Details'
  end

  it "has a valid factory with bank profile details" do
    expect(FactoryGirl.create(:profile_with_bank_details)).to be_valid
    expect(FactoryGirl.create(:profile_with_bank_details).section_name).to match 'Bank Details'
  end

  it "has a valid factory with contact profile details" do
    expect(FactoryGirl.create(:profile_with_contact_details)).to be_valid
    expect(FactoryGirl.create(:profile_with_contact_details).section_name).to match 'Contact Details'
  end

  it "returns list of bank details" do
    expect(FactoryGirl.create(:profile_with_bank_details).bank_details.count).to eq(1)
  end

  it "returns list of general details" do
    expect(FactoryGirl.create(:profile_with_general_details).general_details.count).to eq(1)
  end

  it "returns list of personal details" do
    expect(FactoryGirl.create(:profile_with_personal_details).personal_details.count).to eq(1)
  end

  it "returns list of contact details" do
    expect(FactoryGirl.create(:profile_with_contact_details).contact_details.count).to eq(1)
  end

end

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:organisation)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:organisation, name: nil)).to be_invalid
  end

  it "is invalid without an address" do
    expect(FactoryGirl.build(:organisation, address: nil)).to be_invalid
  end

  it "is invalid without a postal address" do
    expect(FactoryGirl.build(:organisation, postal_address: nil)).to be_invalid
  end

  it "is invalid without a country" do
    expect(FactoryGirl.build(:organisation, country: nil)).to be_invalid
  end

  it "is invalid without an email address" do
    expect(FactoryGirl.build(:organisation, email_address: nil)).to be_invalid
  end

  it "is invalid with bad email address" do
    expect(FactoryGirl.build(:organisation, email_address: 'verybad')).to be_invalid
  end

  it "is invalid without telephones" do
    expect(FactoryGirl.build(:organisation, telephones: nil)).to be_invalid
  end

  it "returns a name" do
    expect(FactoryGirl.create(:organisation, name: 'KCCA').to_s).to match 'KCCA'
  end

end

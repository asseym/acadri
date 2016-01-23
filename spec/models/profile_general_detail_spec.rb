require 'rails_helper'

RSpec.describe ProfileGeneralDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_general_detail)).to be_valid
  end

  # it "is invalid without a user" do
  #   expect(FactoryGirl.build(:profile_general_detail, user: nil)).to be_invalid
  # end

  it "is invalid without a profile" do
    expect(FactoryGirl.build(:profile_general_detail, profile: nil)).to be_invalid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:profile_general_detail, title: nil)).to be_invalid
  end

  it "is invalid without education details" do
    expect(FactoryGirl.build(:profile_general_detail, education: nil)).to be_invalid
  end

  it "is invalid without a date of hiring" do
    expect(FactoryGirl.build(:profile_general_detail, date_hired: nil)).to be_invalid
  end

  it "is invalid without a salary" do
    expect(FactoryGirl.build(:profile_general_detail, salary: nil)).to be_invalid
  end

  it "only accepts integer salary" do
    expect(FactoryGirl.build(:profile_general_detail, salary: 'my money')).to be_invalid
  end

end

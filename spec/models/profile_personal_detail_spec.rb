require 'rails_helper'

RSpec.describe ProfilePersonalDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_personal_detail)).to be_valid
  end

  # it "is invalid without a user" do
  #   expect(FactoryGirl.build(:profile_personal_detail, user: nil)).to be_invalid
  # end

  it "is invalid without a profile" do
    expect(FactoryGirl.build(:profile_personal_detail, profile: nil)).to be_invalid
  end

  it "is invalid without a first name" do
    expect(FactoryGirl.build(:profile_personal_detail, first_name: nil)).to be_invalid
  end

  it "is invalid without other names" do
    expect(FactoryGirl.build(:profile_personal_detail, other_names: nil)).to be_invalid
  end

  it "is invalid without a gender" do
    expect(FactoryGirl.build(:profile_personal_detail, sex: nil)).to be_invalid
  end

  it "is invalid without a birthday" do
    expect(FactoryGirl.build(:profile_personal_detail, birthday: nil)).to be_invalid
  end

  it "is invalid without a nationality" do
    expect(FactoryGirl.build(:profile_personal_detail, nationality: nil)).to be_invalid
  end

  it "returns age" do
    expect(FactoryGirl.create(:profile_personal_detail, birthday: (Faker::Date.between(400.days.ago, 401.days.ago))).age).to eq(1)
  end

end

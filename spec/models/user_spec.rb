require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe "User with Profile" do
    before :each do
      @user = FactoryGirl.create(:user_with_profile)
    end
    it "has a valid factory with profile" do
      expect(@user).to be_valid
    end

    it "stores profiles on the user object" do
      expect(@user.personal_details).to be_a_kind_of(ProfilePersonalDetail)
      expect(@user.contact_details).to be_a_kind_of(ProfileContactDetail)
    end
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:user, name:nil)).to be_invalid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email:nil)).to be_invalid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password:nil)).to be_invalid
  end

  it "is invalid without roles" do
    expect(FactoryGirl.build(:user, roles:nil)).to be_invalid
  end

  it "is invalid with bad email" do
    expect(FactoryGirl.build(:user, email: 'badEmail')).to be_invalid
  end
end

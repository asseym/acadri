require 'rails_helper'

RSpec.describe ProfileBankDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_bank_detail)).to be_valid
  end
end

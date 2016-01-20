require 'rails_helper'

RSpec.describe ProfilePersonalDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_personal_detail)).to be_valid
  end
end

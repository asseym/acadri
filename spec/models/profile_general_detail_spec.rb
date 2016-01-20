require 'rails_helper'

RSpec.describe ProfileGeneralDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_general_detail)).to be_valid
  end
end

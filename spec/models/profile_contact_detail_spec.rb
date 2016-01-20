require 'rails_helper'

RSpec.describe ProfileContactDetail, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:profile_contact_detail)).to be_valid
  end
end

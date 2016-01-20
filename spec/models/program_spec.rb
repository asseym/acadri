require 'rails_helper'

RSpec.describe Program, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end
end

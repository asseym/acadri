require 'rails_helper'

RSpec.describe Training, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:training)).to be_valid
  end
end

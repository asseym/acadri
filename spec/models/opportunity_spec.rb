require 'rails_helper'

RSpec.describe Opportunity, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:opportunity)).to be_valid
  end
end

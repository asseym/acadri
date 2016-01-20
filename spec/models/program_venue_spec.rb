require 'rails_helper'

RSpec.describe ProgramVenue, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program_venue)).to be_valid
  end
end

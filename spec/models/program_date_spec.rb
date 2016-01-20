require 'rails_helper'

RSpec.describe ProgramDate, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:program_date)).to be_valid
  end
end

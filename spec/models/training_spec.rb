require 'rails_helper'

RSpec.describe Training, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:training)).to be_valid
  end

  it "has a valid factory with participants" do
    expect(FactoryGirl.create(:training_with_participants)).to be_valid
  end

  it "automatically gets a title when title is left blank" do
    expect(FactoryGirl.create(:training, title:nil, program:
                                FactoryGirl.create(:program, name: 'Secretarial')).title).to match 'Secretarial'
  end

  it "is invalid without program" do
    expect(FactoryGirl.build(:training, program:nil)).to be_invalid
  end

  it "is invalid without start date" do
    expect(FactoryGirl.build(:training, start_date:nil)).to be_invalid
  end

  it "is invalid without an end date" do
    expect(FactoryGirl.build(:training, end_date:nil)).to be_invalid
  end

  it "is invalid without fees" do
    expect(FactoryGirl.build(:training, fees:nil)).to be_invalid
  end

  it "is invalid without a venue" do
    expect(FactoryGirl.build(:training, program_venue:nil)).to be_invalid
  end

  it "returns title" do
    expect(FactoryGirl.create(:training, title: 'Some Secretarial Kampala').to_s).to match 'Some Secretarial Kampala'
  end

end

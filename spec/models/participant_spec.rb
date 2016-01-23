require 'rails_helper'

RSpec.describe Participant, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:participant)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:participant, name: nil)).to be_invalid
  end

  it "is invalid without sex" do
    expect(FactoryGirl.build(:participant, sex: nil)).to be_invalid
  end

  it "is invalid without job title" do
    expect(FactoryGirl.build(:participant, job_title: nil)).to be_invalid
  end

  it "is invalid without an organisation" do
    expect(FactoryGirl.build(:participant, organisation: nil)).to be_invalid
  end

  it "returns participant's full name" do
    expect(FactoryGirl.create(:participant, name: 'Some', other_names: 'mean guy').to_s).to match "Some Mean Guy"
  end

end

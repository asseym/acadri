require 'rails_helper'

RSpec.describe Participation, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:participation)).to be_valid
  end
end

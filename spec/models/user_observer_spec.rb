require 'rails_helper'

RSpec.describe UserObserver do
  before :each do
    @user = stub_model User
    @observer = UserObserver.instance
  end

  it "invokes after_create on User object" do
    expect(@user).to receive(:create_notification)
    @observer.after_create(@user)
  end

end
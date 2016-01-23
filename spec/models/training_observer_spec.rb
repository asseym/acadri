require 'rails_helper'

RSpec.describe TrainingObserver do
  before :each do
    @training = stub_model Training
    @observer = TrainingObserver.instance
  end

  it "invokes after_create on Training object" do
    expect(@training).to receive(:make_title)
    @observer.after_create(@training)
  end

end
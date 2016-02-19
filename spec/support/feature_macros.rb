include Warden::Test::Helpers

module FeatureMacros
  def sign_in_as(user_factory)
    DatabaseCleaner.clean
    before  do
      @user = FactoryGirl.create(user_factory)
      @user.confirm
      login_as @user, scope: :user, :run_callbacks => false
      @user
    end
  end
end

RSpec.configure do |config|
  config.include FeatureMacros, type: :feature
  config.before :suite do
    Warden.test_mode!
  end

  config.after :each do
    Warden.test_reset!
  end
end
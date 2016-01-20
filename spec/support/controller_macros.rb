module ControllerMacros

  def login_user(factory_name)
    factory_name = :ordinary_user if !factory_name
    factory_name == :admin_user ? mapping = "admin" : "user"
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[mapping]
      user = FactoryGirl.create(factory_name)
      user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end

  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     # sign_in FactoryGirl.create(:admin) # Using factory girl as an example
  #     admin = FactoryGirl.create(:admin_user)
  #     sign_in :user, admin # sign_in(scope, resource)
  #   end
  # end
  #

end
module RequestMacros

  def login_user(factory_name)
    factory_name = :ordinary_user if !factory_name
    before(:each) do
      @user = FactoryGirl.create(factory_name)
      factory_name == :admin_user ? login_as(:admin_user, :scope => :admin) : login_as(@user, :scope => :user)
    end
  end

  def attrs(factory_name)
    FactoryGirl.attributes_for(factory_name)
  end


end
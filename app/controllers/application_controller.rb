class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    
  helper :all # include all helpers, all the time
  protect_from_forgery with: :exception
  
  before_filter :set_current_user
  
  before_filter :authenticate_user!
  before_action :authenticate_user!

  check_authorization
  
  private
  
    def current_user?(user)
      user == current_user
    end
    
    def set_current_user
      User.current_user = current_user
    end
  
=begin  
  private

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
=end
end

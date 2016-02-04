class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    
  helper :all # include all helpers, all the time
  protect_from_forgery with: :exception

  # before_filter :authenticate_user!
  # before_action :authenticate_user!
  #
  # before_filter :set_current_user
  before_filter :set_logged_in

  # if :is_login_page?
  #   skip_authorization_check
  # else
  #   check_authorization
  # end

  # def current_user
  #   @current_user ||= (warden.authenticate(scope: :user) || GuestUser.new)
  # end
  
  private

    def current_user?(user)
      user == current_user
    end

    def set_current_user
      User.current_user = current_user
    end

    def set_logged_in
      @session_exists = ["new"].include?(action_name) && ["user/sessions"].include?(params[:controller]) ||
          request.original_url == user_confirmation_url
    end

    # def set_logged_in
    #   @session_exists = user_signed_in?
    # end

    # def login_page
    #   ["new"].include?(action_name) && ["users/sessions"].include?(params[:controller]) ||
    #       request.original_url == user_confirmation_url
    #   # || request.original_url == edit_user_password_url
    # end

    # def is_login_page?
    #   user_signed_in?
    # end
end

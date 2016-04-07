class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  helper_method :mailbox
  helper_method :conversation
    
  helper :all # include all helpers, all the time
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

  before_action :set_logged_in

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    # flash[:alert] = exception.message
    # redirect_to root_path
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end
  
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

    def mailbox
      @mailbox ||= current_user.mailbox
    end

    def conversation
      @conversation ||= mailbox.conversations.find(params[:id])
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

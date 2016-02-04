class StaticPagesController < ApplicationController
  # before_filter :authenticate_user!
  before_action :authenticate_user!

  before_filter :set_current_user
  before_filter :set_logged_in

  load_and_authorize_resource
  
  def home
    # debugger
  end

  def help
  end
  
  def about
  end
  
  def contact
  end

  private

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

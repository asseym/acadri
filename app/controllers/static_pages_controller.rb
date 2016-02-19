class StaticPagesController < ApplicationController
  # before_action :authenticate_user!, :except => [:index]
  before_action :authenticate_user!

  before_action :set_current_user
  before_action :set_logged_in

  # load_and_authorize_resource except: :index
  load_and_authorize_resource

  def index
  end

  private

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

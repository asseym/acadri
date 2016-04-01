class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }

  # GET /users
  # GET /users.json
  def index
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    users_scope = User.all
    users_scope = users_scope.like(params[:filter]) if params[:filter]
    @users = smart_listing_create(:users,
                                   users_scope,
                                   partial: "users/listing")
    # smart_listing_create partial: "users/listing"
  end

  # GET /users/1
  # GET /users/1.json
  def show
    add_breadcrumb "Users", :users_path, { :title => "Users" }
  end

  # GET /users/new
  def new
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @user = User.new
    @user.build_profile_bank_detail
    @user.build_profile_contact_detail
    @user.build_profile_general_detail
    @user.build_profile_personal_detail
  end

  # GET /users/1/edit
  def edit
    add_breadcrumb "Users", :users_path, { :title => "Users" }
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create(user_params)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.update_attributes(user_params)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
    #  params[:user]
    #end

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation, :roles, :is_staff, :admin, :_destroy,
                                   {:profile_personal_detail_attributes => [:id, :first_name, :other_names, :religion, :sex, :marital_status, :birthday, :nationality, :languages, :_destroy],
                                   :profile_general_detail_attributes => [:id, :education, :staff_id, :date_hired, :passport_number,
                                                                          :drivers_licence, :salary, :NSSF_number, :title, :cv, :photo, :_destroy],
                                   :profile_contact_detail_attributes => [:id, :address, :email_address, :business_phone, :mobile_phone, :home_phone, :fax, :_destroy],
                                   :profile_bank_detail_attributes => [:id, :bank_details, :_destroy]}
      )
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end

    # def smart_listing_resource
    #   @users ||= params[:id] ? User.find(params[:id]) : User.new(params[:user])
    # end
    # helper_method :smart_listing_resource
    #
    # def smart_listing_collection
    #   @users ||= User.all
    # end
    # helper_method :smart_listing_collection
    
end

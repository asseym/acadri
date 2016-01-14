class UsersController < ApplicationController
  
  #Restrict access to logged in users and limit behavior to edit and updates only
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  before_action :authenticate_user!
  before_filter :set_current_user
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }
  
  def index
    @user = current_user
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @users = User.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
  end
  
  def new
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @steps_nav = [:Login, :Personal, :General]
  end
  
  def show
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @user = User.find(params[:id])
  end
  
  def new
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @user = User.new
  end
  
  def create
    add_breadcrumb "Users", :users_path, { :title => "Users" }
    @steps_nav = [:Login, :Personal, :General]
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully Registered The New User"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    add_breadcrumb "Users", :programs_path, { :title => "Users" }
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your Profile has been successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_url
  end

  private
   
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_level, :admin, :is_staff,
      profile_personal_detail_attributes: [:first_name, :other_names, :religion, :sex, :marital_status, :birthday, :nationality, :language],
      profile_general_detail_attributes: [:title, :date_hired, :staff_id, :education, :passport_number, :drivers_licence, :salary, :NSSF_number],
      profile_contact_detail_attributes: [:address, :email_address, :business_phone, :mobile_phone, :home_phone, :fax],
      profile_bank_detail_attributes: [:bank_details]
      )
    end
    
    #Filters
    #Confirm logged in user
    def logged_in_user
      unless user_signed_in?
        store_location
        flash[:danger] = "Please log in first!"
        redirect_to login_url
      end
    end
    
    def set_current_user
      @user = current_user
    end
    
    #Confirm correct user
    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user) 
        flash[:danger] = "Unauthorized access"
        redirect_to root_url
      end 
      #redirect_to(root_url) unless @user == current_user
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end

class AdmissionsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  # skip_before_action :verify_authenticity_token
  load_and_authorize_resource

  before_action :set_admission, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  def index
    add_breadcrumb "admissions", :admissions_path, { :title => "Admissions" }
    admissions_scope = Admission.all
    admissions_scope = admissions_scope.like(params[:filter]) if params[:filter]
    @admissions = smart_listing_create(:admissions,
                                   admissions_scope,
                                   partial: "admissions/listing")
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  # GET /admissions/new
  def new
    add_breadcrumb "admissions", :admissions_path, { :title => "Admissions" }
    @admission = Admission.new
  end

  # GET /admissions/1/edit
  def edit
    add_breadcrumb "admissions", :admissions_path, { :title => "Admissions" }
  end

  # POST /admissions
  # POST /admissions.json
  def create
    @admission = Admission.create(admission_params)
  end

  # PATCH/PUT /admissions/1
  # PATCH/PUT /admissions/1.json
  def update
    @admission.update_attributes(admission_params)
  end

  # DELETE /admissions/1
  # DELETE /admissions/1.json
  def destroy
    @admission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission
      @admission = Admission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admission_params
      params.require(:admission).permit(:id, :training_id, :admission_letter, :admissions_sent)
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

class OrganisationsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /organisations
  # GET /organisations.json
  def index
    add_breadcrumb "organisations", :organisations_path, { :title => "Organisations" }
    smart_listing_create partial: "organisations/listing"
  end

  # GET /organisations/1
  # GET /organisations/1.json
  def show
  end

  # GET /organisations/new
  def new
    add_breadcrumb "organisations", :organisations_path, { :title => "Organisations" }
  end

  # GET /organisations/1/edit
  def edit
    add_breadcrumb "organisations", :organisations_path, { :title => "Organisations" }
  end

  # POST /organisations
  # POST /organisations.json
  def create
    @organisation = Organisation.create(organisation_params)
  end

  # PATCH/PUT /organisations/1
  # PATCH/PUT /organisations/1.json
  def update
    @organisation.update_attributes(organisation_params)
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.json
  def destroy
    @organisation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_params
      params.require(:organisation).permit(:name, :address, :postal_address, :country_id, :telephones, :email_address, :website)
    end

    #Set the current user from devise
    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
  
    def smart_listing_resource
      @organisations ||= params[:id] ? Organisation.find(params[:id]) : Organisation.new(params[:participant])
    end
    helper_method :smart_listing_resource
  
    def smart_listing_collection
      @organisations ||= Organisation.all
    end
    helper_method :smart_listing_collection
end

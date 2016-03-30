class CountriesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_country, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }

  # GET /countries
  # GET /countries.json
  def index
    add_breadcrumb "countries", :countries_path, { :title => "Countries" }
    smart_listing_create partial: "countries/listing"
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    #breadcrumb
    add_breadcrumb "countries", :countries_path, { :title => "Countries" }
  end

  # GET /countries/1/edit
  def edit
    add_breadcrumb "countries", :countries_path, { :title => "Countries" }
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.create(country_params)
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    @country.update_attributes(country_params)
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :c_code, :telephone_code)
    end
    
    #Set the current user from devise
    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end

    def smart_listing_resource
      @countries ||= params[:id] ? Country.find(params[:id]) : Country.new(params[:country])
    end
    helper_method :smart_listing_resource

    def smart_listing_collection
      @countries ||= Country.all
    end
    helper_method :smart_listing_collection
    
end

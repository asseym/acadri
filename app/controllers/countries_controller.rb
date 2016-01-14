class CountriesController < ApplicationController
  
  #Restrict access to logged in users and limit behavior to edit and updates only
  before_action :authenticate_user!
  
  #Current user is needed for all views
  before_filter :set_current_user
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
    
    #breadcrumb
    add_breadcrumb "countries", :countries_path, { :title => "Countries" }
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    #breadcrumb
    add_breadcrumb "countries", :countries_path, { :title => "Countries" }
    
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    
end

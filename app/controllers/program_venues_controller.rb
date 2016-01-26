class ProgramVenuesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  load_and_authorize_resource

  before_action :set_program_venue, only: [:show, :edit, :update, :destroy]

  # GET /program_venues
  # GET /program_venues.json
  def index
    @program_venues = ProgramVenue.all
  end

  # GET /program_venues/1
  # GET /program_venues/1.json
  def show
  end

  # GET /program_venues/new
  def new
    @program_venue = ProgramVenue.new
  end

  # GET /program_venues/1/edit
  def edit
  end

  # POST /program_venues
  # POST /program_venues.json
  def create
    @program_venue = ProgramVenue.new(program_venue_params)

    respond_to do |format|
      if @program_venue.save
        format.html { redirect_to @program_venue, notice: 'Program venue was successfully created.' }
        format.json { render :show, status: :created, location: @program_venue }
      else
        format.html { render :new }
        format.json { render json: @program_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_venues/1
  # PATCH/PUT /program_venues/1.json
  def update
    respond_to do |format|
      if @program_venue.update(program_venue_params)
        format.html { redirect_to @program_venue, notice: 'Program venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @program_venue }
      else
        format.html { render :edit }
        format.json { render json: @program_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_venues/1
  # DELETE /program_venues/1.json
  def destroy
    @program_venue.destroy
    respond_to do |format|
      format.html { redirect_to program_venues_url, notice: 'Program venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_venue
      @program_venue = ProgramVenue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_venue_params
      params.require(:program_venue).permit(:name, :country_id)
    end

    #Set the current user from devise
    def set_current_user
      @user = current_user
    end
end

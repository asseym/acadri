class ProfileContactDetailsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  load_and_authorize_resource

  before_action :set_profile_contact_detail, only: [:show, :edit, :update, :destroy]

  # GET /profile_contact_details
  # GET /profile_contact_details.json
  def index
    @profile_contact_details = ProfileContactDetail.all
  end

  # GET /profile_contact_details/1
  # GET /profile_contact_details/1.json
  def show
  end

  # GET /profile_contact_details/new
  def new
    @profile_contact_detail = ProfileContactDetail.new
  end

  # GET /profile_contact_details/1/edit
  def edit
  end

  # POST /profile_contact_details
  # POST /profile_contact_details.json
  def create
    @profile_contact_detail = ProfileContactDetail.new(profile_contact_detail_params)

    respond_to do |format|
      if @profile_contact_detail.save
        format.html { redirect_to @profile_contact_detail, notice: 'Profile contact detail was successfully created.' }
        format.json { render :show, status: :created, location: @profile_contact_detail }
      else
        format.html { render :new }
        format.json { render json: @profile_contact_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_contact_details/1
  # PATCH/PUT /profile_contact_details/1.json
  def update
    respond_to do |format|
      if @profile_contact_detail.update(profile_contact_detail_params)
        format.html { redirect_to @profile_contact_detail, notice: 'Profile contact detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_contact_detail }
      else
        format.html { render :edit }
        format.json { render json: @profile_contact_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_contact_details/1
  # DELETE /profile_contact_details/1.json
  def destroy
    @profile_contact_detail.destroy
    respond_to do |format|
      format.html { redirect_to profile_contact_details_url, notice: 'Profile contact detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_contact_detail
      @profile_contact_detail = ProfileContactDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_contact_detail_params
      params.require(:profile_contact_detail).permit(:profile_id, :address, :email_address, :business_phone, :mobile_phone, :home_phone, :fax)
    end

    #Set the current user from devise
    def set_current_user
      @user = current_user
    end
end

class ProfilePersonalDetailsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_action :set_profile_personal_detail, only: [:show, :edit, :update, :destroy]

  # GET /profile_personal_details
  # GET /profile_personal_details.json
  def index
    @profile_personal_details = ProfilePersonalDetail.all
  end

  # GET /profile_personal_details/1
  # GET /profile_personal_details/1.json
  def show
  end

  # GET /profile_personal_details/new
  def new
    @profile_personal_detail = ProfilePersonalDetail.new
  end

  # GET /profile_personal_details/1/edit
  def edit
  end

  # POST /profile_personal_details
  # POST /profile_personal_details.json
  def create
    @profile_personal_detail = ProfilePersonalDetail.new(profile_personal_detail_params)

    respond_to do |format|
      if @profile_personal_detail.save
        format.html { redirect_to @profile_personal_detail, notice: 'Profile personal detail was successfully created.' }
        format.json { render :show, status: :created, location: @profile_personal_detail }
      else
        format.html { render :new }
        format.json { render json: @profile_personal_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_personal_details/1
  # PATCH/PUT /profile_personal_details/1.json
  def update
    respond_to do |format|
      if @profile_personal_detail.update(profile_personal_detail_params)
        format.html { redirect_to @profile_personal_detail, notice: 'Profile personal detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_personal_detail }
      else
        format.html { render :edit }
        format.json { render json: @profile_personal_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_personal_details/1
  # DELETE /profile_personal_details/1.json
  def destroy
    @profile_personal_detail.destroy
    respond_to do |format|
      format.html { redirect_to profile_personal_details_url, notice: 'Profile personal detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_personal_detail
      @profile_personal_detail = ProfilePersonalDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_personal_detail_params
      params.require(:profile_personal_detail).permit(:first_name, :other_names, :religion, :sex, :marital_status, :birthday, :nationality, :languages)
    end

    def set_current_user
      @user = current_user
    end
end

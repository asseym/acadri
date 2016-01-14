class ProfileGeneralDetailsController < ApplicationController
  before_action :set_profile_general_detail, only: [:show, :edit, :update, :destroy]

  # GET /profile_general_details
  # GET /profile_general_details.json
  def index
    @profile_general_details = ProfileGeneralDetail.all
  end

  # GET /profile_general_details/1
  # GET /profile_general_details/1.json
  def show
  end

  # GET /profile_general_details/new
  def new
    @profile_general_detail = ProfileGeneralDetail.new
  end

  # GET /profile_general_details/1/edit
  def edit
  end

  # POST /profile_general_details
  # POST /profile_general_details.json
  def create
    @profile_general_detail = ProfileGeneralDetail.new(profile_general_detail_params)

    respond_to do |format|
      if @profile_general_detail.save
        format.html { redirect_to @profile_general_detail, notice: 'Profile general detail was successfully created.' }
        format.json { render :show, status: :created, location: @profile_general_detail }
      else
        format.html { render :new }
        format.json { render json: @profile_general_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_general_details/1
  # PATCH/PUT /profile_general_details/1.json
  def update
    respond_to do |format|
      if @profile_general_detail.update(profile_general_detail_params)
        format.html { redirect_to @profile_general_detail, notice: 'Profile general detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_general_detail }
      else
        format.html { render :edit }
        format.json { render json: @profile_general_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_general_details/1
  # DELETE /profile_general_details/1.json
  def destroy
    @profile_general_detail.destroy
    respond_to do |format|
      format.html { redirect_to profile_general_details_url, notice: 'Profile general detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_general_detail
      @profile_general_detail = ProfileGeneralDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_general_detail_params
      params.require(:profile_general_detail).permit(:education, :staff_id, :date_hired, :passport_number, :drivers_licence, :salary, :NSSF_number)
    end
end

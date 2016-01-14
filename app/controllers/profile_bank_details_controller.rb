class ProfileBankDetailsController < ApplicationController
  before_action :set_profile_bank_detail, only: [:show, :edit, :update, :destroy]

  # GET /profile_bank_details
  # GET /profile_bank_details.json
  def index
    @profile_bank_details = ProfileBankDetail.all
  end

  # GET /profile_bank_details/1
  # GET /profile_bank_details/1.json
  def show
  end

  # GET /profile_bank_details/new
  def new
    @profile_bank_detail = ProfileBankDetail.new
  end

  # GET /profile_bank_details/1/edit
  def edit
  end

  # POST /profile_bank_details
  # POST /profile_bank_details.json
  def create
    @profile_bank_detail = ProfileBankDetail.new(profile_bank_detail_params)

    respond_to do |format|
      if @profile_bank_detail.save
        format.html { redirect_to @profile_bank_detail, notice: 'Profile bank detail was successfully created.' }
        format.json { render :show, status: :created, location: @profile_bank_detail }
      else
        format.html { render :new }
        format.json { render json: @profile_bank_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_bank_details/1
  # PATCH/PUT /profile_bank_details/1.json
  def update
    respond_to do |format|
      if @profile_bank_detail.update(profile_bank_detail_params)
        format.html { redirect_to @profile_bank_detail, notice: 'Profile bank detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_bank_detail }
      else
        format.html { render :edit }
        format.json { render json: @profile_bank_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_bank_details/1
  # DELETE /profile_bank_details/1.json
  def destroy
    @profile_bank_detail.destroy
    respond_to do |format|
      format.html { redirect_to profile_bank_details_url, notice: 'Profile bank detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_bank_detail
      @profile_bank_detail = ProfileBankDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_bank_detail_params
      params.require(:profile_bank_detail).permit(:bank_details)
    end
end

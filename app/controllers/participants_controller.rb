class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  load_and_authorize_resource

  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /participants
  # GET /participants.json
  def index
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
    @participants = Participant.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
  end

  # GET /participants/new
  def new
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:name, :other_names, :sex, :passport_no, :job_title, :organisation_id)
    end
    
    def set_current_user
      @user = current_user
    end
end

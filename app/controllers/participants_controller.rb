class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /participants
  # GET /participants.json
  def index
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
    smart_listing_create partial: "participants/listing"
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
  end

  # GET /participants/new
  def new
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
    # @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
    add_breadcrumb "Participants", :participants_path, { :title => "Participants" }
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.create(participant_params)
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    @participant.update_attributes(participant_params)
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
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

    def set_logged_in
      @session_exists = user_signed_in?
    end
  
    def smart_listing_resource
      @participants ||= params[:id] ? Participant.find(params[:id]) : Participant.new(params[:participant])
    end
    helper_method :smart_listing_resource
  
    def smart_listing_collection
      @participants ||= Participant.all
    end
    helper_method :smart_listing_collection
end

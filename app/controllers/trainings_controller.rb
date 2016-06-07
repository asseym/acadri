class TrainingsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_training, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /trainings
  # GET /trainings.json
  def index
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
    trainings_scope = Training.all
    trainings_scope = trainings_scope.like(params[:filter]) if params[:filter]
    @trainings = smart_listing_create(:trainings,
                                  trainings_scope,
                                  partial: "trainings/listing")
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
  end

  # GET /trainings/new
  def new
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
    @training = Training.new
    @training.participants.build
    @training.participations.build
  end

  # GET /trainings/1/edit
  def edit
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.create(training_params)
    # @training = Training.new(training_params)
    # @training.subscribe(Admission.new)
    # @training.commit
    flash.now[:message] = 'Training was successfully created.'
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    @training.update_attributes(training_params)
    flash.now[:notice] = 'Training was successfully updated.'
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    flash.now[:notice] = 'Training was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:id, :title, :participants_id, :program_id, :start_date, :end_date, :fees, :fees_paid, :fees_balance, :program_venue_id, :_destroy,
                                       {:participations_attributes => [:id, :participant_id, :_destroy]}

      )
    end

    def create_admission
      Admission.make_admission(@training)
    end
    
    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

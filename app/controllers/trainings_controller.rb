class TrainingsController < ApplicationController
  
  before_action :authenticate_user!
  before_filter :set_current_user
  before_action :set_training, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /trainings
  # GET /trainings.json
  def index
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
    @trainings = Training.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
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
  end

  # GET /trainings/1/edit
  def edit
    add_breadcrumb "Trainings", :trainings_path, { :title => "Trainings" }
  end

  # POST /trainings
  # POST /trainings.json
  def create
    @training = Training.new(training_params)

    respond_to do |format|
      if @training.save
        format.html { redirect_to @training, notice: 'Training was successfully created.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to @training, notice: 'Training was successfully updated.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to trainings_url, notice: 'Training was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:participants_id, :program_id, :start_date, :end_date, :fees, :fees_paid, :fees_balance, :program_venue_id)
    end
    
    def set_current_user
      @user = current_user
    end
end

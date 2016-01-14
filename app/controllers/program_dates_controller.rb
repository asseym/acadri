class ProgramDatesController < ApplicationController
  before_action :set_program_date, only: [:show, :edit, :update, :destroy]

  # GET /program_dates
  # GET /program_dates.json
  def index
    @program_dates = ProgramDate.all
  end

  # GET /program_dates/1
  # GET /program_dates/1.json
  def show
  end

  # GET /program_dates/new
  def new
    @program_date = ProgramDate.new
  end

  # GET /program_dates/1/edit
  def edit
  end

  # POST /program_dates
  # POST /program_dates.json
  def create
    @program_date = ProgramDate.new(program_date_params)

    respond_to do |format|
      if @program_date.save
        format.html { redirect_to @program_date, notice: 'Program date was successfully created.' }
        format.json { render :show, status: :created, location: @program_date }
      else
        format.html { render :new }
        format.json { render json: @program_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_dates/1
  # PATCH/PUT /program_dates/1.json
  def update
    respond_to do |format|
      if @program_date.update(program_date_params)
        format.html { redirect_to @program_date, notice: 'Program date was successfully updated.' }
        format.json { render :show, status: :ok, location: @program_date }
      else
        format.html { render :edit }
        format.json { render json: @program_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_dates/1
  # DELETE /program_dates/1.json
  def destroy
    @program_date.destroy
    respond_to do |format|
      format.html { redirect_to program_dates_url, notice: 'Program date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_date
      @program_date = ProgramDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_date_params
      params.require(:program_date).permit(:date)
    end
end

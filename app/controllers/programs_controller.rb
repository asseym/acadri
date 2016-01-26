class ProgramsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  load_and_authorize_resource

  before_action :set_program, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  
  #steps :new, :venues, :dates

  # GET /programs
  # GET /programs.json
  def index
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }
    @programs = Program.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }    
  end

  # GET /programs/new
  def new
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }
    @steps_nav = [:basic, :dates, :venues]
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }
  end

  # POST /programs
  # POST /programs.json
  def create
    @steps_nav = [:basic, :dates, :venues]
    
    #@program = Program.new(program_params)

    @program = Program.create(name: program_params[:name], 
                           category_id: program_params[:category_id], 
                           description: program_params[:description])

    if(program_params.include? :programdates_attributes and program_params.include? :programvenues_attributes)
      #save dates
      program_params[:programdates_attributes].each do |n, attributes|
        @program.programdates.build(attributes)
      end
      #save venues
      program_params[:programvenues_attributes].each do |n, attributes|
        @program.programvenues.build(attributes)
      end
      @program.save
    end
   
    respond_to do |format|
      if @program.save
        #format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.html {redirect_to programs_url, notice: 'Program was successfully created.' }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { render :show, status: :ok, location: @program }
      else
        Rails.logger.info(@program.errors.messages.inspect)
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url, notice: 'Program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def program_params
    #  params[:program]
    #end
    
    def program_params
      params.require(:program).permit!
    end
    
    def set_current_user
      @user = current_user
    end
end

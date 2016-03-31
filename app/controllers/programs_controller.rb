class ProgramsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_program, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  
  #steps :new, :venues, :dates

  # GET /programs
  # GET /programs.json
  def index
    add_breadcrumb "programs", :programs_path, { :title => "Programs" }
    programs_scope = Program.all
    programs_scope = programs_scope.like(params[:filter]) if params[:filter]
    @programs = smart_listing_create(:programs,
                                  programs_scope,
                                  partial: "programs/listing")
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }    
  end

  # GET /programs/new
  def new
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
    add_breadcrumb "Programs", :programs_path, { :title => "Programs" }
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.create(program_params)
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    @program.update_attributes(program_params)
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
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
      # params.require(:program).permit!
      params.require(:program).permit(:name, :category_id, :description, :is_service, :_destroy,
                                   {:programdates_attributes => [:start_date, :end_date, :_destroy],
                                    :programvenues_attributes => [:name, :country_id, :_destroy]}
      )
    end
    
    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

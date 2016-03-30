class OpportunitiesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  skip_before_action :verify_authenticity_token
  load_and_authorize_resource

  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  # skip_load_resource :only => [:create]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /opportunities
  # GET /opportunities.json
  def index
    add_breadcrumb "opportunities", :opportunities_path, { :title => "Opportunities" }
    opportunity_scope = Opportunity.all
    opportunity_scope = opportunity_scope.like(params[:filter]) if params[:filter]
    @opportunities = smart_listing_create(:opportunities,
                                              opportunity_scope,
                                              partial: "opportunities/listing",
                                              default_sort: { created_at: "desc" })
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
    add_breadcrumb "opportunities", :opportunities_path, { :title => "Opportunities" }
    add_breadcrumb "opportunity# #{@opportunity.id}", @opportunity, { :title => @opportunity.id }
  end

  # GET /opportunities/new
  def new
    add_breadcrumb "opportunities", :opportunities_path, { :title => "Opportunities" }
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
    add_breadcrumb "opportunities", :opportunities_path, { :title => "Opportunities" }
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    # @opportunity = Opportunity.create!(opportunity_params)
    @opportunity = Opportunity.new(opportunity_params)
    
    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    # @opportunity.update_attributes(opportunity_params)
    # flash[:success] = "Updated Successfully"
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        format.html { render :edit }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    @opportunity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      Rails.logger.info('test info')
      params.require(:opportunity).permit(:title, :description, :opportunity_status_id, :user_id, :attachment, :_destroy)
    end
    
    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

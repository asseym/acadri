class RfqsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_rfq, only: [:show, :edit, :update, :destroy]

  # GET /rfqs
  # GET /rfqs.json
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "work", :root_path, { :title => "Work" }
  def index
    add_breadcrumb "rfqs", :rfqs_path, { :title => "Rfqs" }
    rfqs_scope = Rfq.all
    rfqs_scope = rfqs_scope.like(params[:filter]) if params[:filter]
    @rfqs = smart_listing_create(:rfqs,
                                     rfqs_scope,
                                     partial: "rfqs/listing")
  end

  # GET /rfqs/1
  # GET /rfqs/1.json
  def show
  end

  # GET /rfqs/new
  def new
    add_breadcrumb "rfqs", :rfqs_path, { :title => "Rfqs" }
    @rfq = Rfq.new
  end

  # GET /rfqs/1/edit
  def edit
    add_breadcrumb "rfqs", :rfqs_path, { :title => "Rfqs" }
  end

  # POST /rfqs
  # POST /rfqs.json
  def create
    @rfq = Rfq.create(rfq_params)
  end

  # PATCH/PUT /rfqs/1
  # PATCH/PUT /rfqs/1.json
  def update
    @rfq.update_attributes(rfq_params)
  end

  # DELETE /rfqs/1
  # DELETE /rfqs/1.json
  def destroy
    @rfq.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rfq
      @rfq = Rfq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rfq_params
      params.require(:rfq).permit(:rfq_id, :action, :rfq_date, :due_date, :issuer, :description)
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

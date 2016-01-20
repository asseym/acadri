class AccountsInvoicesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  load_and_authorize_resource

  before_action :set_accounts_invoice, only: [:show, :edit, :update, :destroy]

  # skip_load_resource :only => [:create]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }

  # GET /accounts_invoices
  # GET /accounts_invoices.json
  def index
    add_breadcrumb "Invoices", :accounts_invoices_path, { :title => "Invoices" }
    @accounts_invoices = AccountsInvoice.paginate(page: params[:page], :per_page => Settings.pagination_per_page)
  end

  # GET /accounts_invoices/1
  # GET /accounts_invoices/1.json
  def show
    add_breadcrumb "Invoices", :accounts_invoices_path, { :title => "Invoices" }
  end

  # GET /accounts_invoices/new
  def new
    add_breadcrumb "Invoices", :accounts_invoices_path, { :title => "Invoices" }
    @accounts_invoice = AccountsInvoice.new
  end

  # GET /accounts_invoices/1/edit
  def edit
    add_breadcrumb "Invoices", :accounts_invoices_path, { :title => "Invoices" }
  end

  # POST /accounts_invoices
  # POST /accounts_invoices.json
  def create
    @accounts_invoice = AccountsInvoice.new(accounts_invoice_params)

    respond_to do |format|
      if @accounts_invoice.save
        format.html { redirect_to @accounts_invoice, notice: 'Accounts invoice was successfully created.' }
        format.json { render :show, status: :created, location: @accounts_invoice }
      else
        format.html { render :new }
        format.json { render json: @accounts_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts_invoices/1
  # PATCH/PUT /accounts_invoices/1.json
  def update
    respond_to do |format|
      if @accounts_invoice.update(accounts_invoice_params)
        format.html { redirect_to @accounts_invoice, notice: 'Accounts invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @accounts_invoice }
      else
        format.html { render :edit }
        format.json { render json: @accounts_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts_invoices/1
  # DELETE /accounts_invoices/1.json
  def destroy
    @accounts_invoice.destroy
    respond_to do |format|
      format.html { redirect_to accounts_invoices_url, notice: 'Accounts invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accounts_invoice
      @accounts_invoice = AccountsInvoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accounts_invoice_params
      params.require(:accounts_invoice).permit(:training_id, :invoice_date, :invoice_terms, :currency)
      # params.require(:accounts_invoice).permit!
    end
    
    def set_current_user
      @user = current_user
    end
end

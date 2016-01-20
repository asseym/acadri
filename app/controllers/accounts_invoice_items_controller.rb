class AccountsInvoiceItemsController < ApplicationController

  before_action :authenticate_user!
  before_filter :set_current_user
  before_action :set_accounts_invoice_item, only: [:show, :edit, :update, :destroy]

  # GET /accounts_invoice_items
  # GET /accounts_invoice_items.json
  def index
    @accounts_invoice_items = AccountsInvoiceItem.all
  end

  # GET /accounts_invoice_items/1
  # GET /accounts_invoice_items/1.json
  def show
  end

  # GET /accounts_invoice_items/new
  def new
    @accounts_invoice_item = AccountsInvoiceItem.new
  end

  # GET /accounts_invoice_items/1/edit
  def edit
  end

  # POST /accounts_invoice_items
  # POST /accounts_invoice_items.json
  def create
    @accounts_invoice_item = AccountsInvoiceItem.new(accounts_invoice_item_params)

    respond_to do |format|
      if @accounts_invoice_item.save
        format.html { redirect_to @accounts_invoice_item, notice: 'Accounts invoice item was successfully created.' }
        format.json { render :show, status: :created, location: @accounts_invoice_item }
      else
        format.html { render :new }
        format.json { render json: @accounts_invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts_invoice_items/1
  # PATCH/PUT /accounts_invoice_items/1.json
  def update
    respond_to do |format|
      if @accounts_invoice_item.update(accounts_invoice_item_params)
        format.html { redirect_to @accounts_invoice_item, notice: 'Accounts invoice item was successfully updated.' }
        format.json { render :show, status: :ok, location: @accounts_invoice_item }
      else
        format.html { render :edit }
        format.json { render json: @accounts_invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts_invoice_items/1
  # DELETE /accounts_invoice_items/1.json
  def destroy
    @accounts_invoice_item.destroy
    respond_to do |format|
      format.html { redirect_to accounts_invoice_items_url, notice: 'Accounts invoice item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accounts_invoice_item
      @accounts_invoice_item = AccountsInvoiceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accounts_invoice_item_params
      params.require(:accounts_invoice_item).permit(:description, :units, :unit_cost, :subtotal)
    end

    def set_current_user
      @user = current_user
    end
end

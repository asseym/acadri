class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  def index
    add_breadcrumb "expenses", :expenses_path, { :title => "Expenses" }
    expenses_scope = Expense.all
    expenses_scope = expenses_scope.like(params[:filter]) if params[:filter]
    @expenses = smart_listing_create(:expenses,
                                      expenses_scope,
                                      partial: "expenses/listing")
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    add_breadcrumb "expenses", :expenses_path, { :title => "Expenses" }
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
    add_breadcrumb "expenses", :expenses_path, { :title => "Expenses" }
  end

  # POST /expenses
  # POST /expenses.json
  def create
    add_breadcrumb "expenses", :expenses_path, { :title => "Expenses" }
    @expense = Expense.create(expense_params)
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    @expense.update_attributes(expense_params)
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:item, :description, :expense_date, :qty, :unit_price, :tax, :invoice_ref)
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

class ExpenseCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_expense_category, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }
  def index
    add_breadcrumb "expense_categories", :expense_categories_path, { :title => "Expense Categories" }
    expense_categories_scope = ExpenseCategory.all
    expense_categories_scope = expense_categories_scope.like(params[:filter]) if params[:filter]
    @expense_categories = smart_listing_create(:expense_categories,
                                     expense_categories_scope,
                                     partial: "expense_categories/listing")
  end

  # GET /expense_categories/1
  # GET /expense_categories/1.json
  def show
  end

  # GET /expense_categories/new
  def new
    add_breadcrumb "expense_categories", :expense_categories_path, { :title => "Expense Categories" }
    @expense_category = Expense.new
  end

  # GET /expense_categories/1/edit
  def edit
    add_breadcrumb "expense_categories", :expense_categories_path, { :title => "Expense Categories" }
  end

  # POST /expense_categories
  # POST /expense_categories.json
  def create
    add_breadcrumb "expense_categories", :expense_categories_path, { :title => "Expense Categories" }
    @expense_category = Expense.create(expense_category_params)
  end

  # PATCH/PUT /expense_categories/1
  # PATCH/PUT /expense_categories/1.json
  def update
    @expense_category.update_attributes(expense_category_params)
  end

  # DELETE /expense_categories/1
  # DELETE /expense_categories/1.json
  def destroy
    @expense_category.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_expense_category
    @expense_category = ExpenseCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_category_params
    params.require(:expense_category).permit(:id, :name, :_destroy,
                                             {:expense_sub_categories_attributes => [:id, :name, :_destroy] }
    )
  end

  def set_current_user
    @user = current_user
  end

  def set_logged_in
    @session_exists = user_signed_in?
  end
end

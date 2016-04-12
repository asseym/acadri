class SupplyItemCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_supply_item_category, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }
  def index
    add_breadcrumb "supply_item_categories", :supply_item_categories_path, { :title => "Supply Item Categories" }
    supply_item_categories_scope = SupplyItemCategory.all
    supply_item_categories_scope = supply_item_categories_scope.like(params[:filter]) if params[:filter]
    @supply_item_categories = smart_listing_create(:supply_item_categories,
                                               supply_item_categories_scope,
                                               partial: "supply_item_categories/listing")
  end

  # GET /supply_item_categories/1
  # GET /supply_item_categories/1.json
  def show
  end

  # GET /supply_item_categories/new
  def new
    add_breadcrumb "supply_item_categories", :supply_item_categories_path, { :title => "Supply Item Categories" }
    @supply_item_category = SupplyItemCategory.new
  end

  # GET /supply_item_categories/1/edit
  def edit
    add_breadcrumb "supply_item_categories", :supply_item_categories_path, { :title => "Supply Item Categories" }
  end

  # POST /supply_item_categories
  # POST /supply_item_categories.json
  def create
    add_breadcrumb "supply_item_categories", :supply_item_categories_path, { :title => "Supply Item Categories" }
    @supply_item_category = SupplyItemCategory.create(supply_item_category_params)
  end

  # PATCH/PUT /supply_item_categories/1
  # PATCH/PUT /supply_item_categories/1.json
  def update
    @supply_item_category.update_attributes(supply_item_category_params)
  end

  # DELETE /supply_item_categories/1
  # DELETE /supply_item_categories/1.json
  def destroy
    @supply_item_category.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_supply_item_category
    @supply_item_category = SupplyItemCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def supply_item_category_params
    params.require(:supply_item_category).permit(:id, :name, :_destroy,
                                             {:supply_items_attributes => [:id, :name, :_destroy] }
    )
  end

  def set_current_user
    @user = current_user
  end

  def set_logged_in
    @session_exists = user_signed_in?
  end
end

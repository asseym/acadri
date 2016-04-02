class SuppliersController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource
  
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  def index
    add_breadcrumb "suppliers", :suppliers_path, { :title => "Suppliers" }
    suppliers_scope = Supplier.all
    suppliers_scope = suppliers_scope.like(params[:filter]) if params[:filter]
    @suppliers = smart_listing_create(:suppliers,
                                     suppliers_scope,
                                     partial: "suppliers/listing")
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    add_breadcrumb "suppliers", :suppliers_path, { :title => "Suppliers" }
    @supplier = Supplier.new
    @supplier.supply_items.build
    @supplier.supplies.build
    @supply_item_categories = SupplyItemCategory.order(:name)
    @supply_items = SupplyItem.order(:name)
    # @categorized_items = SupplyItem.joins(:supply_item_category).order("supply_items.name").group("supply_item_categories.name")
  end

  # GET /suppliers/1/edit
  def edit
    @supply_item_categories = SupplyItemCategory.order(:name)
    @supply_items = SupplyItem.order(:name)
    add_breadcrumb "suppliers", :suppliers_path, { :title => "Suppliers" }
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.create(supplier_params)
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    @supplier.update_attributes(supplier_params)
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      # params.require(:supplier).permit(:id, :name, :shop_name, :contact_numbers, :address, :town, :country_id, :_destroy,
      #                                  {:supplies_attributes => [:id, :supply_item_id, :_destroy]})
      params.require(:supplier).permit(:id, :name, :shop_name, :contact_numbers, :address, :town, :country_id,
                                       {:supply_item_ids => []})
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

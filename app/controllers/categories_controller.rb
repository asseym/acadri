class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "settings", :root_path, { :title => "Settings" }

  # GET /categories
  # GET /categories.json
  def index
    add_breadcrumb "categories", :categories_path, { :title => "Categories" }
    smart_listing_create partial: "categories/listing"
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    add_breadcrumb "categories", :categories_path, { :title => "Categories" }
  end

  # GET /categories/new
  def new
    add_breadcrumb "categories", :categories_path, { :title => "Categories" }
  end

  # GET /categories/1/edit
  def edit
    add_breadcrumb "categories", :categories_path, { :title => "Categories" }
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.create(category_params)
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category.update_attributes(category_params)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end

    def smart_listing_resource
      @categories ||= params[:id] ? Category.find(params[:id]) : Category.new(params[:category])
    end
    helper_method :smart_listing_resource

    def smart_listing_collection
      @categories ||= Category.all
    end
    helper_method :smart_listing_collection
end

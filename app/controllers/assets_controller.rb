class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "sales", :root_path, { :title => "Sales" }
  def index
    add_breadcrumb "assets", :assets_path, { :title => "Assets" }
    assets_scope = Asset.all
    assets_scope = assets_scope.like(params[:filter]) if params[:filter]
    @assets = smart_listing_create(:assets,
                                     assets_scope,
                                     partial: "assets/listing")
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    add_breadcrumb "assets", :assets_path, { :title => "Assets" }
    @asset = Asset.new
  end

  # GET /assets/1/edit
  def edit
    add_breadcrumb "assets", :assets_path, { :title => "Assets" }
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.create(asset_params)
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    @asset.update_attributes(asset_params)
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:name, :description, :asset_category, :current_value, :country_id)
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

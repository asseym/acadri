class StaticPagesController < ApplicationController
  # before_action :authenticate_user!, :except => [:index]
  before_action :authenticate_user!

  before_action :set_current_user
  before_action :set_logged_in

  before_action :insert_search_fields, :only => :search

  # load_and_authorize_resource except: :index
  load_and_authorize_resource

  def index
  end

  def search
    @search = Search.new(StaticPage, params[:search])
    # @search.order = 'email'  # optional
    @search_results = @search.run
    @search_term = params[:title]

    respond_to do |format|
      format.html # search.html.haml
      format.xml  { render :xml => @search_results }
    end
  end

  private

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_static_page
      @static_page = StaticPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def static_page_params
      params.require(:static_page).permit(:search, :query)
    end

    def insert_search_fields
      params[:title] = params.delete :query
    end

end

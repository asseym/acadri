class TasksController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user
  before_filter :set_logged_in
  load_and_authorize_resource

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  add_breadcrumb "home", :root_path, { :title => "Home" }
  add_breadcrumb "work", :root_path, { :title => "Work" }
  def index
    add_breadcrumb "tasks", :tasks_path, { :title => "Tasks" }
    tasks_scope = Task.all
    tasks_scope = tasks_scope.like(params[:filter]) if params[:filter]
    @tasks = smart_listing_create(:tasks,
                                     tasks_scope,
                                     partial: "tasks/listing")
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    add_breadcrumb "tasks", :tasks_path, { :title => "Tasks" }
    @task = Task.new
    @task.assignments.build
    @task.users.build
  end

  # GET /tasks/1/edit
  def edit
    add_breadcrumb "tasks", :tasks_path, { :title => "Tasks" }
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.create(task_params)
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task.update_attributes(task_params)
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:id, :title, :task_type, :start_date, :end_date, :status, :description, :_destroy,
                                   {:assignments_attributes => [:id, :user_id, :_destroy]}
      )
    end

    def set_current_user
      @user = current_user
    end

    def set_logged_in
      @session_exists = user_signed_in?
    end
end

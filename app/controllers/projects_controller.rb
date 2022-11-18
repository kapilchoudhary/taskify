# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_status, only: %i[index search]

  def index
    @projects = Project.all
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def search
    @projects =  Project.projects_filter(params.slice(:start_date, :end_date, :status, :search))
    respond_to do |format|
      format.html { render :index }
    end
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    respond_to do |format|
      if params[:status].present?
        status = params[:status].to_i
        @project = Project.find(params[:project_id]) if params[:project_id].present?
        if @project.update(status: status)
          format.html { redirect_to request.referrer, notice: "status was updated" }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :start_date)
  end

  def set_status
    @status = Project::statuses
  end 
end

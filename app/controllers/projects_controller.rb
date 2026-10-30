class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.owned_projects.find_by(id: params[:id]) || current_user.projects.find_by(id: params[:id])

    if @project.nil?
      raise ActiveRecord::RecordNotFound.new('project not found')
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.owned_projects.build(project_params)
    # The creator is added as an admin member so the project shows up in their project list.
    @project.memberships.build(user: current_user, role: "admin")

    if @project.save
      redirect_to @project, notice: "Project created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end

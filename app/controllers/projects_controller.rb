class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  def index
    @projects = current_user.projects
  end

  def show
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

  def edit
    raise ActiveRecord::RecordNotFound.new("project not found") unless @project.manageable_by?(current_user)
  end

  def update
    raise ActiveRecord::RecordNotFound.new("project not found") unless @project.manageable_by?(current_user)

    if @project.update(project_params)
      redirect_to @project, notice: "Project renamed."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    raise ActiveRecord::RecordNotFound.new("project not found") unless @project.deletable_by?(current_user)

    @project.destroy!
    redirect_to authenticated_root_path, notice: "Project deleted.", status: :see_other
  end

  private

  def set_project
    @project = current_user.owned_projects.find_by(id: params[:id]) || current_user.projects.find_by(id: params[:id])

    if @project.nil?
      raise ActiveRecord::RecordNotFound.new("project not found")
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end
end

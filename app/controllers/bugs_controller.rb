class BugsController < ApplicationController
  before_action :set_project

  def index
  end

  def show
    @bug = @project.bugs.find(params[:id])
  end

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user
    if @bug.save
      redirect_to @project, notice: "Bug added to project."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title)
  end
end

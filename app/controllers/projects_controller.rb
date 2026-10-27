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

end

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # blank page
    @projects = current_user.projects + current_user.owned_projects
  end
end

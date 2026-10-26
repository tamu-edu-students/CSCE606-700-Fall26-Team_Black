class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # blank page
  end
end

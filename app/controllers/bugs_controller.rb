class BugsController < ApplicationController
  def index
  end

  def show
    @bug = Bug.find(params[:id])
  end
end

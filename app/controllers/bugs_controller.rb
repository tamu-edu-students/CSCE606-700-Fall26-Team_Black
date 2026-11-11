class BugsController < ApplicationController
  def index
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
  end
end

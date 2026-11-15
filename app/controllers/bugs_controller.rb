class BugsController < ApplicationController
  def index
  end

  def show
    @bug = Bug.find(params[:id])
    @comments = @bug.comments.includes(:user).order(created_at: :asc)
  end
end

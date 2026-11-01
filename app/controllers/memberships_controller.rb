class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find(params[:project_id])
    raise ActiveRecord::RecordNotFound.new("project not found") unless project.manageable_by?(current_user)

    user = User.find_by(email: params[:email])
    membership = project.memberships.build(user: user, role: params[:role])

    if user && membership.save
      redirect_to project, notice: "#{user.name || user.email} added as #{membership.role}."
    else
      redirect_to project, alert: user ? membership.errors.full_messages.to_sentence : "No user with that email."
    end
  end
end

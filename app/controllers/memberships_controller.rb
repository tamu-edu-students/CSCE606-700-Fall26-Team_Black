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

  def update
    project = Project.find(params[:project_id])
    raise ActiveRecord::RecordNotFound.new("project not found") unless project.manageable_by?(current_user)

    membership = project.memberships.find(params[:id])
    user = membership.user

    if user.id == project.owner_id
      redirect_to project, alert: "The project owner's role can't be changed."
    elsif membership.update(role: params[:role])
      redirect_to project, notice: "#{user.name || user.email} is now a #{membership.role}."
    else
      redirect_to project, alert: membership.errors.full_messages.to_sentence
    end
  end

  def destroy
    membership = current_user.memberships.find_by!(id: params[:id], project_id: params[:project_id])
    project = membership.project

    if project.owner_id == current_user.id
      redirect_to project, alert: "Project owners can't leave their project."
    else
      membership.destroy!
      redirect_to authenticated_root_path, notice: "You left the project.", status: :see_other
    end
  end
end

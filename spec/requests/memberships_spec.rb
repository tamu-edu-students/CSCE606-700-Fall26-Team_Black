require "rails_helper"

RSpec.describe "Memberships" do
  let(:project) { create(:project) }
  let(:new_member) { create(:user, name: "Kris") }

  describe "POST /projects/:project_id/memberships" do
    it "lets a project admin add a user with a role" do
      sign_in project.owner

      expect {
        post project_memberships_path(project), params: { email: new_member.email, role: "developer" }
      }.to change(project.memberships, :count).by(1)

      expect(project.memberships.find_by(user: new_member).role).to eq("developer")
      expect(response).to redirect_to(project_path(project))
      expect(flash[:notice]).to eq("Kris added as developer.")
    end

    it "rejects an email with no matching user" do
      sign_in project.owner

      expect {
        post project_memberships_path(project), params: { email: "nobody@example.com", role: "developer" }
      }.not_to change(Membership, :count)

      expect(flash[:alert]).to eq("No user with that email.")
    end

    it "rejects adding someone who is already a member" do
      create(:membership, project:, user: new_member)
      sign_in project.owner

      expect {
        post project_memberships_path(project), params: { email: new_member.email, role: "admin" }
      }.not_to change(Membership, :count)

      expect(flash[:alert]).to eq("User has already been taken")
    end

    it "rejects an unsupported role" do
      sign_in project.owner

      expect {
        post project_memberships_path(project), params: { email: new_member.email, role: "superuser" }
      }.not_to change(Membership, :count)

      expect(flash[:alert]).to eq("Role is not included in the list")
    end

    it "is not found for members who are not admins" do
      developer = create(:membership, project:, role: "developer").user
      sign_in developer

      expect {
        post project_memberships_path(project), params: { email: new_member.email, role: "developer" }
      }.not_to change(Membership, :count)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH /projects/:project_id/memberships/:id" do
    let!(:membership) { create(:membership, project:, user: new_member, role: "developer") }

    it "lets a project admin change a member's role" do
      sign_in project.owner

      patch project_membership_path(project, membership), params: { role: "manager" }

      expect(membership.reload.role).to eq("manager")
      expect(response).to redirect_to(project_path(project))
      expect(flash[:notice]).to eq("Kris is now a manager.")
    end

    it "rejects an unsupported role" do
      sign_in project.owner

      patch project_membership_path(project, membership), params: { role: "superuser" }

      expect(membership.reload.role).to eq("developer")
      expect(flash[:alert]).to eq("Role is not included in the list")
    end

    it "does not change the project owner's role" do
      admin = create(:membership, project:, role: "admin").user
      owner_membership = project.memberships.find_by(user: project.owner)
      sign_in admin

      patch project_membership_path(project, owner_membership), params: { role: "developer" }

      expect(owner_membership.reload.role).to eq("admin")
      expect(flash[:alert]).to eq("The project owner's role can't be changed.")
    end

    it "is not found for members who are not admins" do
      developer = create(:membership, project:, role: "developer").user
      sign_in developer

      patch project_membership_path(project, membership), params: { role: "admin" }

      expect(membership.reload.role).to eq("developer")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /projects/:project_id/memberships/:id" do
    it "lets a member leave the project" do
      membership = create(:membership, project:, user: new_member)
      sign_in new_member

      expect {
        delete project_membership_path(project, membership)
      }.to change(project.memberships, :count).by(-1)

      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to eq("You left the project.")
    end

    it "does not let the owner leave their own project" do
      owner_membership = project.memberships.find_by(user: project.owner)
      sign_in project.owner

      expect {
        delete project_membership_path(project, owner_membership)
      }.not_to change(Membership, :count)

      expect(response).to redirect_to(project_path(project))
      expect(flash[:alert]).to eq("Project owners can't leave their project.")
    end

    it "is not found when removing someone else's membership" do
      other = create(:membership, project:, user: new_member)
      developer = create(:membership, project:, role: "developer").user
      sign_in developer

      expect {
        delete project_membership_path(project, other)
      }.not_to change(Membership, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end

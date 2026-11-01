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
end

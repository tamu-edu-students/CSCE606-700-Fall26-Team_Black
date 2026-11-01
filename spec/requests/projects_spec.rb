require "rails_helper"

RSpec.describe "Projects" do
  describe "GET /projects/new" do
    it "renders the form for a logged-in user" do
      sign_in create(:user)

      get new_project_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("New Project")
    end

    it "redirects visitors to log in" do
      get new_project_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /projects" do
    it "creates a project owned by the current user with them as an admin member" do
      user = create(:user)
      sign_in user

      expect { post projects_path, params: { project: { name: "New" } } }.to change(Project, :count).by(1)

      created = Project.last
      expect(created.owner).to eq(user)
      expect(created.memberships.find_by(user:).role).to eq("admin")
      expect(response).to redirect_to(project_path(created))
    end

    it "rejects a blank name" do
      sign_in create(:user)

      expect { post projects_path, params: { project: { name: "" } } }.not_to change(Project, :count)
      expect(response).to have_http_status(:unprocessable_content)
    end

    it "does not let visitors create a project" do
      expect { post projects_path, params: { project: { name: "New" } } }.not_to change(Project, :count)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "PATCH /projects/:id" do
    let(:project) { create(:project, name: "Old Name") }

    it "lets the owner rename the project" do
      sign_in project.owner

      patch project_path(project), params: { project: { name: "New Name" } }

      expect(response).to redirect_to(project_path(project))
      expect(project.reload.name).to eq("New Name")
    end

    it "lets a project admin rename the project" do
      sign_in create(:membership, project:, role: "admin").user

      patch project_path(project), params: { project: { name: "New Name" } }

      expect(project.reload.name).to eq("New Name")
    end

    it "rejects a blank name" do
      sign_in project.owner

      patch project_path(project), params: { project: { name: "" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(project.reload.name).to eq("Old Name")
    end

    it "is not found for members who are not admins" do
      sign_in create(:membership, project:, role: "developer").user

      patch project_path(project), params: { project: { name: "New Name" } }

      expect(response).to have_http_status(:not_found)
      expect(project.reload.name).to eq("Old Name")
    end
  end

  describe "DELETE /projects/:id" do
    let(:project) { create(:project) }

    it "lets the owner delete the project along with its bugs, comments, and memberships" do
      create(:comment, bug: create(:bug, project:))
      sign_in project.owner

      expect { delete project_path(project) }
        .to change(Project, :count).by(-1)
        .and change(Bug, :count).by(-1)
        .and change(Comment, :count).by(-1)
        .and change(Membership, :count).by(-1)

      expect(response).to redirect_to(authenticated_root_path)
    end

    it "is not found for a project admin who is not the owner" do
      sign_in create(:membership, project:, role: "admin").user

      expect { delete project_path(project) }.not_to change(Project, :count)
      expect(response).to have_http_status(:not_found)
    end
  end
end

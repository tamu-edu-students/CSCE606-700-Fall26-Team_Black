require "rails_helper"

RSpec.describe Project do
  it "requires a name and an owner" do
    project = Project.new

    expect(project).not_to be_valid
    expect(project.errors[:name]).to include("can't be blank")
    expect(project.errors[:owner]).to include("must exist")
  end

  it "exposes users through memberships" do
    project = create(:project)
    member = create(:membership, project:).user

    expect(project.users).to include(project.owner, member)
  end
end

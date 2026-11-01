require "rails_helper"

RSpec.describe Membership do
  it "requires a user, project, and supported role" do
    membership = Membership.new

    expect(membership).not_to be_valid
    expect(membership.errors[:user]).to include("must exist")
    expect(membership.errors[:project]).to include("must exist")
    expect(membership.errors[:role]).to include("is not included in the list")
  end

  it "accepts each supported project role" do
    Membership::ROLES.each do |role|
      membership = Membership.new(user: User.new, project: Project.new, role:)

      expect(membership).to be_valid, "#{role} should be a valid role"
    end
  end

  it "prevents duplicate memberships for a user and project" do
    existing = create(:membership)
    duplicate = Membership.new(user: existing.user, project: existing.project, role: "admin")

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:user_id]).to include("has already been taken")
  end
end

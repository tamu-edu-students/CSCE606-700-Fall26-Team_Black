require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "requires a user, project, and supported role" do
    membership = Membership.new

    assert_not membership.valid?
    assert_includes membership.errors[:user], "must exist"
    assert_includes membership.errors[:project], "must exist"
    assert_includes membership.errors[:role], "is not included in the list"
  end

  test "accepts each supported project role" do
    Membership::ROLES.each do |role|
      membership = Membership.new(user: User.new, project: Project.new, role:)

      assert membership.valid?, "#{role} should be a valid role"
    end
  end

  test "prevents duplicate memberships for a user and project" do
    membership = Membership.new(
      user: memberships(:one).user,
      project: memberships(:one).project,
      role: "admin"
    )

    assert_not membership.valid?
    assert_includes membership.errors[:user_id], "has already been taken"
  end
end

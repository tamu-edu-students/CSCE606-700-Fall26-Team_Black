require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "exposes users through memberships" do
    assert_includes projects(:one).users, users(:one)
  end
end

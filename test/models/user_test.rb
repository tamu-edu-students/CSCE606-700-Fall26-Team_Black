require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires an email and password" do
    user = User.new

    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
    assert_includes user.errors[:password], "can't be blank"
  end

  test "authenticates using the stored password" do
    user = User.create!(
      email: "developer@example.com",
      password: "password",
      password_confirmation: "password"
    )

    assert user.valid_password?("password")
    assert_not user.valid_password?("incorrect")
  end

  test "exposes projects through memberships" do
    assert_includes users(:one).projects, projects(:one)
  end
end

require "test_helper"

class DeviseAuthenticationTest < ActionDispatch::IntegrationTest
  test "renders the sign-in page" do
    get new_user_session_path

    assert_response :success
    assert_select "h2", "Log in"
  end

  test "renders the sign-up page" do
    get new_user_registration_path

    assert_response :success
    assert_select "h2", "Sign up"
  end
end

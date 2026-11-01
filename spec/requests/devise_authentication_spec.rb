require "rails_helper"

RSpec.describe "Devise authentication" do
  it "renders the sign-in page" do
    get new_user_session_path

    expect(response).to have_http_status(:success)
    expect(response.body).to include("Log in")
  end

  it "renders the combined page for sign-up" do
    get new_user_registration_path

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include("Sign up")
  end
end

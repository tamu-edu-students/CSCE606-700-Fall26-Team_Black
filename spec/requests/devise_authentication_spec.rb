require "rails_helper"

RSpec.describe "Devise authentication" do
  let(:password) { "password" }

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

  describe "sign-up" do
    let(:user_attributes) do
      {
        email: "new-user@example.com",
        password:,
        password_confirmation: password
      }
    end

    it "creates an account and signs the user in" do
      expect do
        post user_registration_path, params: { user: user_attributes }
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(authenticated_root_path)
      follow_redirect!
      expect(response.body).to include("Edit Profile")
    end

    it "renders the combined page when the password confirmation is invalid" do
      expect do
        post user_registration_path,
             params: { user: user_attributes.merge(password_confirmation: "different") }
      end.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("Password confirmation doesn&#39;t match Password")
      expect(response.body).to include("Log in")
      expect(response.body).to include("Sign up")
    end
  end

  describe "login and logout" do
    let!(:user) { create(:user, password:) }

    it "signs in with valid credentials" do
      post user_session_path, params: { user: { email: user.email, password: } }

      expect(response).to redirect_to(authenticated_root_path)
      follow_redirect!
      expect(response.body).to include("Edit Profile")
    end

    it "rejects invalid credentials" do
      post user_session_path, params: { user: { email: user.email, password: "incorrect" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("Log in")
      expect(response.body).to include("Invalid")
    end

    it "signs the user out" do
      sign_in user

      delete destroy_user_session_path

      expect(response).to redirect_to(unauthenticated_root_path)
      follow_redirect!
      expect(response.body).to include("Log in")
      expect(response.body).not_to include("Edit Profile")
    end
  end

  describe "password recovery" do
    let!(:user) { create(:user, password:) }

    before do
      ActionMailer::Base.deliveries.clear
    end

    it "sends password reset instructions" do
      post user_password_path, params: { user: { email: user.email } }

      expect(response).to redirect_to(new_user_session_path)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
    end

    it "changes the password using the emailed reset token" do
      post user_password_path, params: { user: { email: user.email } }
      reset_url = ActionMailer::Base.deliveries.last.body.encoded.match(/href="([^"]+)"/)[1]
      reset_token = Rack::Utils.parse_nested_query(URI.parse(reset_url).query)["reset_password_token"]

      put user_password_path,
          params: {
            user: {
              reset_password_token: reset_token,
              password: "new-password",
              password_confirmation: "new-password"
            }
          }

      expect(response).to redirect_to(authenticated_root_path)
      expect(user.reload.valid_password?("new-password")).to be(true)
      expect(user.valid_password?(password)).to be(false)
    end
  end

  describe "changing a password while signed in" do
    let!(:user) { create(:user, password:) }

    it "updates the password when the current password is correct" do
      sign_in user

      put user_registration_path,
          params: {
            user: {
              current_password: password,
              password: "new-password",
              password_confirmation: "new-password"
            }
          }

      expect(response).to redirect_to(authenticated_root_path)
      expect(user.reload.valid_password?("new-password")).to be(true)
      expect(user.valid_password?(password)).to be(false)
    end

    it "does not update the password when the current password is incorrect" do
      sign_in user

      put user_registration_path,
          params: {
            user: {
              current_password: "incorrect",
              password: "new-password",
              password_confirmation: "new-password"
            }
          }

      expect(response).to have_http_status(:unprocessable_content)
      expect(user.reload.valid_password?(password)).to be(true)
    end
  end
end

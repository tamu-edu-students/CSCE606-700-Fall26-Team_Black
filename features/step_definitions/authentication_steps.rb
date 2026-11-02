Given("I am logged in") do
  @user = create(:user, name: "Current User")
  visit "/"
  within(".log_in") do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end
end

Given("I visit the sign-in and sign-up page") do
  visit new_user_session_path
end

Given("an account exists with email {string}") do |email|
  @user = create(:user, email:, password: "password", password_confirmation: "password")
end

When("I sign up with email {string}, password {string}, and confirmation {string}") do |email, password, confirmation|
  visit new_user_session_path
  within(".sign_up") do
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: confirmation
    click_button "Sign up"
  end
  @user = User.find_by(email:)
end

Then("I should be signed in") do
  expect(page).to have_content("Edit Profile")
end

Then("I should see a password confirmation error") do
  expect(page).to have_content("Password confirmation doesn't match Password")
end

When("I log in with email {string} and password {string}") do |email, password|
  visit new_user_session_path
  within(".log_in") do
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end
end

When("I log out") do
  find("summary").click
  click_button "Sign out"
end

Then("I should be signed out") do
  expect(page).to have_content("Log in")
  expect(page).not_to have_content("Edit Profile")
end

When("I request a password reset for {string}") do |email|
  ActionMailer::Base.deliveries.clear
  visit new_user_password_path
  fill_in "Email", with: email
  click_button "Send me password reset instructions"
end

When("I follow the password reset link and choose {string}") do |password|
  email = ActionMailer::Base.deliveries.last
  reset_url = email.body.encoded.match(/href="([^"]+)"/)[1]
  visit URI.parse(reset_url).request_uri
  fill_in "New password", with: password
  fill_in "Confirm new password", with: password
  click_button "Change my password"
  find("summary").click
  click_button "Sign out"
end

When("I change my password to {string}") do |password|
  find("summary").click
  click_link "Edit Profile"
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  fill_in "Current password", with: "password"
  click_button "Update"
  find("summary").click
  click_button "Sign out"
end

When("I log in with password {string}") do |password|
  step %(I log in with email "#{@user.email}" and password "#{password}")
end

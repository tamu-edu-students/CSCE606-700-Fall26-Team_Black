Given("I am logged in") do
  @user = create(:user, name: "Current User")
  visit "/"
  within(".log_in") do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end
end

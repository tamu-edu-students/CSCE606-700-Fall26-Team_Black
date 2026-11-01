Given("I own a project named {string}") do |name|
  create(:project, name:, owner: @user)
end

Given("I am a(n) {string} on a project named {string}") do |role, name|
  create(:membership, project: create(:project, name:), user: @user, role:)
end

Given("a user named {string} exists with email {string}") do |name, email|
  create(:user, name:, email:)
end

When("I create a project named {string}") do |name|
  visit "/"
  click_link "New project"
  fill_in "Name", with: name
  click_button "Create project"
end

When("I go to my dashboard") do
  visit "/"
end

When("I visit the project {string}") do |name|
  visit project_path(Project.find_by!(name:))
end

When("I rename the project {string} to {string}") do |old_name, new_name|
  step %(I visit the project "#{old_name}")
  click_link "Rename"
  fill_in "Name", with: new_name
  click_button "Save"
end

When("I delete the project {string}") do |name|
  step %(I visit the project "#{name}")
  click_button "Delete project"
end

When("I add {string} to the project {string} as a(n) {string}") do |email, name, role|
  step %(I visit the project "#{name}")
  fill_in "email", with: email
  select role, from: "role"
  click_button "Add member"
end

Then("I should be listed as an {string} of the project") do |role|
  step %("#{@user.name}" should be listed as an "#{role}" of the project)
end

Then("{string} should be listed as a(n) {string} of the project") do |name, role|
  expect(page).to have_css(".flex-container", text: /#{name}\s*#{role}/)
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

Then("I should not see the {string} button") do |label|
  expect(page).not_to have_button(label)
end

Then("I should not see {string}") do |text|
  expect(page).not_to have_content(text)
end

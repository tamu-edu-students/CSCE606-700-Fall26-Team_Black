Given("a bug titled {string} exists") do |title|
  @bug = create(:bug, title:, project: create(:project, owner: @user), user: @user)
end

When("I view the bug") do
  visit bug_path(@bug)
end

When("I post a comment {string}") do |comment|
  fill_in "comment_comment", with: comment
  click_button "Post Comment"
end

Then("the comment should be attributed to me") do
  expect(page).to have_css(".comment strong", text: @user.name)
end

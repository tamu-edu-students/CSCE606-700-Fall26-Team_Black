When('I create a bug named {string} with description {string}, replication {string}, priority {string}, and status {string}') do |name, description, replication, priority, status|
  step %(I visit the project "#{name}")
  click_link "New bug"
  fill_in "Name", with: name
  fill_in "Description", with: description
  fill_in "Replication", with: replication
  fill_in "Priority", with: priority
  fill_in "Status", with: status
  click_button "Create bug"
end

When('I change the status of the bug {string} from {string} to {string}') do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I change the priority of the bug {string} from {string} to {string}') do |string, string2, string3|
  pending # Write code here that turns the phrase above into concrete actions
end
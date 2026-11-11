Feature: Editing bugs
  As a user
  I want to edit a bug
  So that it can accuritly reflect the current issue

  Background:
    Given I am logged in

  Scenario: Changing a bugs status
    Given I am an "admin" on a project named "Project"
    When I change the status of the bug "New Bug" from "open" to "closed"
    Then I should see "Status changed."

  Scenario: Changing a bugs priority
    Given I am an "admin" on a project named "Project"
    When I change the priority of the bug "New Bug" from "urgent" to "routine"
    Then I should see "Priority changed."
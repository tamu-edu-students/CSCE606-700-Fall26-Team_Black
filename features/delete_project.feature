Feature: Deleting projects
  As a project owner
  I want to delete a project
  So that abandoned projects don't clutter my dashboard

  Background:
    Given I am logged in

  Scenario: Deleting a project I own
    Given I own a project named "Doomed"
    When I delete the project "Doomed"
    Then I should see "Project deleted."
    And I should not see "Doomed"

  Scenario: A project admin who is not the owner cannot delete it
    Given I am an "admin" on a project named "Shared"
    When I visit the project "Shared"
    Then I should not see the "Delete project" button

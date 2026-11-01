Feature: Creating projects
  As a user
  I want to create a project
  So that I can track bugs and their status

  Background:
    Given I am logged in

  Scenario: Creating a project
    When I create a project named "Bug Tracker"
    Then I should see "Project created."
    And I should be listed as an "admin" of the project

  Scenario: A new project appears on my dashboard
    When I create a project named "Bug Tracker"
    And I go to my dashboard
    Then I should see "Bug Tracker"

  Scenario: Creating a project without a name
    When I create a project named ""
    Then I should see "Name can't be blank"

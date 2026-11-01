Feature: Adding members
  As a project admin
  I want to add users to my project with a role
  So that they can work on its bugs

  Background:
    Given I am logged in
    And I own a project named "Team"

  Scenario: Adding a member
    Given a user named "Kris" exists with email "kris@example.com"
    When I add "kris@example.com" to the project "Team" as a "developer"
    Then I should see "Kris added as developer."
    And "Kris" should be listed as a "developer" of the project

  Scenario: Adding an email with no account
    When I add "nobody@example.com" to the project "Team" as a "developer"
    Then I should see "No user with that email."

  Scenario: A developer cannot add members
    Given I am a "developer" on a project named "Shared"
    When I visit the project "Shared"
    Then I should not see the "Add member" button

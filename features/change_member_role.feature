Feature: Changing a member's role
  As a project admin
  I want to change a member's role
  So that I can set what they are able to do in the project

  Background:
    Given I am logged in
    And I own a project named "Team"
    And "Kris" is a "developer" on the project "Team"

  Scenario: Changing a member's role
    When I change the role of "Kris" on the project "Team" to "manager"
    Then I should see "Kris is now a manager."
    And "Kris" should be listed as a "manager" of the project

  Scenario: The project owner's role cannot be changed
    When I visit the project "Team"
    Then I should not be able to change the role of "Current User" on the project "Team"

  Scenario: A developer cannot change roles
    Given I am a "developer" on a project named "Shared"
    When I visit the project "Shared"
    Then I should not see the "Update role" button

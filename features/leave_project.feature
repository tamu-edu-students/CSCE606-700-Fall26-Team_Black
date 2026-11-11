Feature: Leaving a project
  As a project member
  I want to leave a project I no longer work on
  So that it no longer clutters my dashboard

  Background:
    Given I am logged in

  Scenario: Leaving a project I am a member of
    Given I am a "developer" on a project named "Shared"
    When I leave the project "Shared"
    Then I should see "You left the project."
    And I should not see "Shared"

  Scenario: A project owner cannot leave their own project
    Given I own a project named "Team"
    When I visit the project "Team"
    Then I should not see the "Leave project" button

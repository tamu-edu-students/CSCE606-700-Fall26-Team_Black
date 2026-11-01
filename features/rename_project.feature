Feature: Renaming projects
  As a project admin
  I want to rename a project
  So that its name reflects what it is for

  Background:
    Given I am logged in

  Scenario: Renaming a project I own
    Given I own a project named "Old Name"
    When I rename the project "Old Name" to "New Name"
    Then I should see "Project renamed."
    And I should see "New Name"

  Scenario: Renaming a project to a blank name
    Given I own a project named "Old Name"
    When I rename the project "Old Name" to ""
    Then I should see "Name can't be blank"

  Scenario: A developer cannot rename a project
    Given I am a "developer" on a project named "Shared"
    When I visit the project "Shared"
    Then I should not see "Rename"

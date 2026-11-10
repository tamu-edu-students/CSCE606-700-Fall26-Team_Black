Feature: Creating projects
  As a user
  I want to report a bug
  So that other people can track and work to fix it

  Background:
    Given I am logged in

  Scenario: Creating a bug
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug named "New Bug"
    Then I should see "Bug created."
    And I should see "New Bug"

  Scenario: Creating a bug without a name
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug named ""
    Then I should see "Name can't be blank"

  Scenario: Creating a bug without a description
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug with description ""
    Then I should see "Description can't be blank"

  Scenario: Creating a bug without replication steps
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug with replication ""
    Then I should see "Replication can't be blank"

  Scenario: Creating a bug without a priority
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug with priority ""
    Then I should see "Priority can't be blank"

 Scenario: Creating a bug without a status
    Given I am an "developer" on a project named "Project"
    When I visit the project "Project"
    When I create a bug with status ""
    Then I should see "Status can't be blank"
Feature: Bug comments
  As a user
  I want to comment on bugs
  So that I can share information about them

  Background:
    Given I am logged in

  Scenario: Viewing a bug with no comments
    Given a bug titled "New Bug" exists
    When I view the bug
    Then I should see "Comments (0)"
    And I should see "No comments yet."

  Scenario: Posting a comment
    Given a bug titled "New Bug" exists
    When I view the bug
    And I post a comment "I can reproduce this"
    Then I should see "Comments (1)"
    And I should see "I can reproduce this"
    And the comment should be attributed to me

  Scenario: Posting a blank comment
    Given a bug titled "New Bug" exists
    When I view the bug
    And I post a comment ""
    Then I should see "Comments (0)"
    And I should see "No comments yet."

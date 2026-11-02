Feature: Authentication
  As a user
  I want to manage my account access
  So that I can securely use the application

  Scenario: Signing up with valid credentials
    Given I visit the sign-in and sign-up page
    When I sign up with email "new-user@example.com", password "password", and confirmation "password"
    Then I should be signed in

  Scenario: Signing up with a mismatched password confirmation
    Given I visit the sign-in and sign-up page
    When I sign up with email "new-user@example.com", password "password", and confirmation "different"
    Then I should see a password confirmation error

  Scenario: Logging in and logging out
    Given an account exists with email "user@example.com"
    When I log in with email "user@example.com" and password "password"
    Then I should be signed in
    When I log out
    Then I should be signed out

  Scenario: Resetting a forgotten password
    Given an account exists with email "user@example.com"
    When I request a password reset for "user@example.com"
    And I follow the password reset link and choose "new-password"
    When I log in with password "new-password"
    Then I should be signed in

  Scenario: Changing a password from the account profile
    Given I am logged in
    When I change my password to "new-password"
    When I log in with password "new-password"
    Then I should be signed in

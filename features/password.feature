Feature: Reset Password
  In case a user forgets their password
  They should be able to submit their email address
  to receive an email address with instructions of how to reset their password

  Scenario: User can reset his/her password
    Given I exist as a user with email address "email@example.com"
    And I am not logged in
    When I click the Forgot Password? link
    And I fill in "forgot-password" with "email@example.com"
    And I click "forgot-btn"
    And I receive 1 password reset email at "email@example.com"
    When I open the email
    Then I should see "Change my password" in the email body
    When I follow "Change my password" in the email
    Then I should see "Change your password"
    When When I submit my new password details
    And I am not logged in
    And I login with the new password
    Then I should be signed in
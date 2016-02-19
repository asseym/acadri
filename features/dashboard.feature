Feature: Display Dashboard
  In order to restrict functionality
  every user has a personalized landing page / dashboard
  only super users/admins/ceo and higher groups get access
  to the general system dashboard

  Scenario: Super user gets access to general dashboard
    Given I exist as a "superadmin"
    And I sign in with valid credentials
    Then I should be signed in
    And I should see the header "Dashboard"
    And I should see a sub-header "statistics summary and reports"

  Scenario: Admin user gets access to general dashboard
    Given I exist as a "admin_user"
    And I sign in with valid credentials
    Then I should be signed in
    And I should see the header "Dashboard"
    And I should see a sub-header "statistics summary and reports"

  Scenario: Ceo user gets access to general dashboard
    Given I exist as a "ceo_user"
    And I sign in with valid credentials
    Then I should be signed in
    And I should see the header "Dashboard"
    And I should see a sub-header "statistics summary and reports"

  Scenario: Staff user gets access to their custom dashboard
    Given I exist as a "staff_user" with name "Joe Smith"
    And I sign in with valid credentials
    Then I should be signed in
    And I should see the header "Dashboard"
    And I should see a sub-header "dashboard for Joe Smith"
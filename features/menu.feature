Feature: Menu Bar
  In order to allow access to the different
  functions of the system. The system should display a menu bar
  which grants priviledged access to the different functions of the system

  Scenario: logging in by a user displays a menu bar
    Given I exist as a "staff_user"
    And I sign in with valid credentials
    Then I should be signed in
    And I should see the menu bar

  Scenario: signing in as a super admin gives access to all menus
    Given I exist as a "superadmin"
    And I sign in with valid credentials
    Then I should see the menu bar
    And I should see all menus

  Scenario: signing in as a ceo gives access to all menus
    Given I exist as a "ceo_user"
    And I sign in with valid credentials
    Then I should see the menu bar
    And I should see all menus

  Scenario: signing in as an admin gives access to all menus except "users" menu
    Given I exist as a "admin_user"
    And I sign in with valid credentials
    Then I should see the menu bar
    And I should see all menus except
      |Users|
      |Employees List |
      |Contracts      |
      |Loans          |

  Scenario: signing in as a program coordinator gives access to all except settings and accounts
    Given I exist as a "program_coordinator_user"
    And I sign in with valid credentials
    Then I should see the menu bar
    And I should see all menus except
    |Settings|
    |Countries|
    |Users    |
    |Course Categories|
    |Invoices         |
    |Expenses         |
    |Assets           |
    |Employees List   |
    |Contracts        |
    |Loans            |

  Scenario: signing in as a staff user gives access to all menus except some as listed below
    Given I exist as a "staff_user"
    And I sign in with valid credentials
    Then I should see the menu bar
    And I should see all menus except
      |Settings|
      |Countries|
      |Users    |
      |Course Categories|
      |Invoices         |
      |Expenses         |
      |Assets           |
      |Training         |
      |Suppliers List   |
      |Employees List   |
      |Contracts        |
      |Loans            |
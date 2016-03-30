Feature: Accounts Invoice
  The system should be able to create, retrieve
  update and destroy accounts invoices

  Scenario: I should be able to list all accounts invoices by clicking the invoices button
    Given I exist as a "finance_user"
    And 2 "accounts_invoice" exist in the database
    And I sign in with valid credentials
    When I click on the "Sales" menu
    And I click on the "Invoices" menu
    Then I should see a list of account invoices

  Scenario: I should be able to see an invoice by clicking on its title/training title
    Given I exist as a "finance_user"
    And 2 "accounts_invoice" exist in the database
    And I sign in with valid credentials
    When I click on the "Sales" menu
    And I click on the "Invoices" menu
    And I click on the first invoice training title
    Then I should see the invoice
    When I click on the "invoices" breadcrumb
    Then I should see a list of account invoices

  Scenario: I should be able to create an invoice
    Given I exist as a "finance_user"
    And 0 "accounts_invoices" exist in the database
    And 1 "training_with_participants" exists in the database
    And I sign in with valid credentials
    And I click on the "Sales" menu
    And I click on the "Invoices" menu
    When I click on the "/accounts_invoices/new" link
    Then I should see an "accounts_invoice" create form
    When I fill in the following information
    |1|2016-03-22|New test invoice terms|usd|
    And I click on the "save" button
    Then I should see the new invoice 1 created

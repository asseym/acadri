Feature: To provide some key features to logged in user
  the system displays a header which acts as a gateway
  to user specific functionality and search functionality

  Scenario: As a logged in User, I see a page header
    Given I exist as a "staff_user" with name "Joe Smith"
    And I am not logged in
    Then I do not see a page header
    When I am logged in
    Then I see a page header
    And I see a page logo in the header
    And I see a menu toggler in the header
    And I see a search button in the header
    And I see a notification panel in the header
    And I see a messages panel in the header
    And I see a tasks panel in the header
    And I see my name "Joe" in the header

  Scenario: As a logged in User, clicking on the logo takes me to the dashboard
    Given I exist as a "staff_user" with name "Joe Smith"
    When I am logged in
    And I click the page logo
    Then I am directed to the dashboard

  Scenario: Clicking on the search icon expands the search form
    Given I exist as a "staff_user" with name "Joe Smith"
    When I am logged in
    And I click the search magnifier icon
    Then I see a search form with a "search..." placeholder

  Scenario: I can type and search for something using the search form
    Given I exist as a "staff_user" with name "Joe Smith"
    And I am logged in
    When I click the search magnifier icon
    And I type in the search form "something_that_can_not_be_found"
    When I click the search link
#    Then I see a search results page
#    And I see the search term "something_that_can_not_be_found"
#    And I see a "Results Not Found" title

  Scenario: I can see my notifications
    Given I exist as a "staff_user" with name "Joe Smith"
    And I have a notifaction "My test Notification"
    And I am logged in
    When I click the notification panel
    Then I see a list of my notifications including "My test Notification"
    When I click on a notification
    Then I am directed to my dashboard

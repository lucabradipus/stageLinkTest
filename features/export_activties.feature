Feature: user can export to csv page activities
  As a platform user
  I want to be able to insert pages ID
  to export a limited number of activities to a csv


  Scenario: user can login with facebook
    Given I am on the home page
    And I am not yet logged in
    Then I can log in
    And see the query form

  Scenario Template: user can fill more than one line in the form
    Given I am logged in
    Then I can add more lines to the form
    And I can fill page id with pageid <page> and limit <limit>
    Then I  can export a csv file
#    And the content of the csv wiil be |table|

    Examples:
      | page  | limit |
      | first_page | 10    |


Feature: user can export to csv page activities
  As a platform user
  I want to be able to insert pages ID
  to export a limited number of activities to a csv

  Scenario: user can fill more than one line in the form
    Given I am logged in
    Then I can add more lines to the form
    And I can fill page id with pageid first_page and limit 10
    And I can add more lines to the form
    Then I  can export a csv file

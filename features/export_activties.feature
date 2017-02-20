Feature: user can export to csv page activities
  As a platform user
  I want to be able to insert pages ID
  to export a limited number of activities to a csv


  Scenario: user can login with facebook
    Given I am on the home page
    And I am not yet logged in
    Then I can log in
    And see the query form


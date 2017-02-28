Feature: user can login with facebbok activities
  As a platform user
  I want to be able to login with my facebook user
  to export a limited number of activities to a csv

  Scenario: user can login with facebook
    Given I am on the home page
    And I am not yet logged in
    Then I can log in
    And I can see the query form

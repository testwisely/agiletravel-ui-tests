@feature
Feature: Select Flights 
  As a regiestered user
  I can select flights
  
  Scenario: Oneway Trip
    Given I am signed in as "agileway"
    When select oneway trip
    And select depart from "Sydney" to "New York" on "07" of "May 2021"
    And click "Continue"
    Then I should see "2021-05-07", "New York" and "Sydney" on next page
  
  Scenario: Return Trip
    Given I am signed in as "agileway"
    When select return trip
    And select depart from "Sydney" to "New York" on "07" of "May 2021"
    And return on "12" of "June 2021"
    And click "Continue"
    Then I should see "2021-05-07", "New York" and "Sydney" on next page
    And I should see "2021-06-12", "Sydney" and "New York" on next page

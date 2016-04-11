Feature: Passenger
  As a reigstered user
  I can enter passenger details

  Scenario: Passenger Details
    Given I am signed in as "agileway"
    And select oneway trip
    And select depart from "Sydney" to "New York" on "07" of "May 2012"
    And click "Continue"
    When I enter "Bob" and "Tester" as passenger name
    And click 'Next' on the passenger page
    Then I should see "Bob Tester" shown in card holder name on the next payment page
  
  

  

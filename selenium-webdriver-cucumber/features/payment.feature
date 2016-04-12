Feature: Payment
  As a reigstered user
  I can pay the flight using my credit card

  Scenario: Passenger Details
    Given I am signed in as "agileway"
    And select oneway trip
    And select depart from "Sydney" to "New York" on "07" of "May 2016"
    When click "Continue"
    And I enter "Bob" and "Tester" as passenger name
    When click 'Next' on the passenger page
    And select 'Visa' card
    And enter card holder name "Bob the Tester"
    And enter card number "4242424242424242"
    And select card expiry date "07" of "2016"
    When I click 'Pay now'
    Then I should see 'Booking Number' in confirmation section
  
  

  

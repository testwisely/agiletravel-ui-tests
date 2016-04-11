Feature: User Authentication
  As a registered user
  I want sign in

  Scenario: Sign in
    Given I am on the home page
    When I enter user name "agileway" and password "test"
    And click the 'Sign in' button
    Then I signed in successfully
  
  

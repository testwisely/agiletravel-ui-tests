Feature: User Authentication
  As a reigstered user
  I can log in 

  Scenario: Registered user can log in sucessfully
    Given I am on the home page
    When enter user name "agileway" and password "testwise"
    And click "Sign in" button
    Then I am logged in
  
  
  

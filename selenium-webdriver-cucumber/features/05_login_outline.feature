@feature
Feature: User Authentication Outline
  As a reigstered user
  I can log in 

  Scenario Outline: Registered user with different role can log in sucessfully
    Given I am on the home page
    When enter user name "<username>" and password "<password>"
    And click "Sign in" button
    Then I am logged in
    And I sign off
    Examples:
    | username | password |
    | admin    | secret   |
    | agileway | testwise |
  
  

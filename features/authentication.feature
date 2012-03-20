@wip
Feature: Authentication
  In order to perform API interactions that require authentication
  As a developer
  I want to be able to authenticate via multiple forms of authentication

  Scenario: Basic Auth
    Given I have a username and password
    When I authenticate using Basic Auth
    Then I should be authenticated

  Scenario: OAuth
    Given I have a client_id and a client_secret
    When I authenticate using OAuth
    Then I should be authenticated

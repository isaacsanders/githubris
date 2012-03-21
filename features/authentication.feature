Feature: Authentication
  In order to perform API interactions that require authentication
  As a developer
  I want to be able to authenticate via multiple forms of authentication

  Scenario: Basic Auth (good)
    Given I have a username and password
    When I authenticate using Basic Auth
    Then I should be authenticated

  Scenario: Basic Auth (bad)
    Given I have a fake username and password
    When I authenticate using Basic Auth
    Then I should not be authenticated

  Scenario: Basic Auth (missing)
    When I authenticate using Basic Auth
    Then I should not be authenticated

  @backlog
  Scenario: OAuth
    Given I have a client_id and a client_secret
    When I authenticate using OAuth
    Then I should be authenticated

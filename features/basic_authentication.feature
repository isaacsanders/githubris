Feature: Authentication
  In order to perform API interactions easily
  As a developer
  I want to be able to authenticate via Basic Auth

  Scenario: Credentials are good
    Given I have a username and password
    When I authenticate using Basic Auth
    Then I should be authenticated

  Scenario: Credentials are bad
    Given I have a fake username and password
    When I authenticate using Basic Auth
    Then I should not be authenticated

  Scenario: Credentials are missing
    When I authenticate using Basic Auth
    Then I should not be authenticated

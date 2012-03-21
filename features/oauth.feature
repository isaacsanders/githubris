@backlog
Feature: OAuth
  In order to perform API interactions with more security
  As a developer
  I want to be able to authenticate via OAuth

  Scenario: OAuth
    Given I have a client_id and a client_secret
    When I authenticate using OAuth
    Then I should be authenticated

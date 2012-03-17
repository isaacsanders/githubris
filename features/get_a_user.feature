Feature: Get a user
  In order to retrieve data about a user
  As a developer
  I want to be able to get a user's data

  Scenario: Getting a user
    When I access "@githubris.find_user('GithubrisTestUser')"
    Then I have that user

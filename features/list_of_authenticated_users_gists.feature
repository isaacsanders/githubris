@wip
Feature: List of Authenticated User's Gists
  In order to gather gist data from a user
  As a developer
  I want to be able to retreive gists from an authenticated user

  Scenario: Listing an authenticated user's gists
    Given there is an authenticated user
    When I access "@githubris.authenticated_user.gists"
    Then I should have some private and public gists

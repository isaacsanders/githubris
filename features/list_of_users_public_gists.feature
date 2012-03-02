@backlog
Feature: List of user's public gists
  In order to view all of the public gists another user has made,
  As a user of the Githubris GitHub API,
  I want to be able to access the gists via the API.

  Scenario: via Githubris
    When I access "@githubris.public_gists(user: 'GithubrisTestUser')"
    Then I have GithubrisTestUser's public gists

  Scenario: via the User
    Given @user is GithubrisTestUser
    When I access "@user.public_gists"
    Then I have GithubrisTestUser's public gists

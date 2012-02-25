Feature: List of user's public gists
  In order to view all of the public gists another user has made,
  As a user of the Githubris GitHub API,
  I want to be able to access the gists via the API.

  Scenario Outline: Accessing a user's public gists via the githubris API
    Given I have an instance of Githubris
    When I access "@githubris.public_gists(<key>: 'GithubrisTestUser')"
    Then I should have a list of the user's public gists

  Scenario Outline: Accessing a user's public gists via the githubris API
    Given I have an instance of Githubris
    And I have an instance of Githubris::User
    When I access "@githubris.public_gists(<key>: @user)"
    Then I should have a list of the user's public gists

  Scenario Outline: Accessing a user's public gists via the githubris API
    Given I have an instance of Githubris
    When I access "@githubris.gists(<key>: 'GithubrisTestUser')"
    Then I should have a list of the user's public gists

  Scenario Outline: Accessing a user's public gists via the githubris API
    Given I have an instance of Githubris
    And I have an instance of Githubris::User
    When I access "@githubris.gists(<key>: @user)"
    Then I should have a list of the user's public gists

  Examples:
    | key     |
    | for     |
    | user    |
    | owner   |
    | author  |
    | creator |

  Scenario: Accessing a user's public gists via the user
    Given I have an instance of Githubris::User
    When I access "@user.public_gists"
    Then I should have a list of the user's public gists

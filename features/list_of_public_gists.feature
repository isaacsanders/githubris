Feature: List of Public Gists
  In order to evaluate the data created by gist makers
  As a developer
  I want to be able to see a list of public gists

  Scenario: Asking for public gists
    When I access "@githubris.public_gists"
    Then I should have a default number of gists

  Scenario: Asking for a certain page of public gists
    When I access "@githubris.public_gists(page: 60)"
    Then I should have a default number of gists

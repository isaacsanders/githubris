Feature: Get a Gist
  In order to retrieve the newest gist data for a given gist
  As a developer
  I want to be able to get a gist.

  Scenario: Get a gist via the Githubris API
    When I access "@githubris.find_gist(1)"
    Then I have the first gist

  Scenario: Reload a gist's information
    Given @gist is a stale copy of the first gist
    When I access "@gist.reload"
    Then I have the newest version of the gist

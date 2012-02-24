Then /^I should have a list of the user's public gists$/ do
  @actual.should eql test_public_gists
end

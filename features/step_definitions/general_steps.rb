Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

Then /^I have GithubrisTestUser's public gists$/ do
  @actual.should eql test_public_gists
end

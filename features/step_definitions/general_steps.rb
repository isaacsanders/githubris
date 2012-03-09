Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

Then /^I have GithubrisTestUser's public gists$/ do
  @actual.should == test_user_public_gists
end

Then /^I should have a default number of gists$/ do
  @actual.count.should eql 30
end

Then /^I should have (\d+) gists$/ do |count|
  @actual.count.should eql Integer(count)
end


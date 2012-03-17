Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

Then /^I have the default number of gists$/ do
  @actual.count.should eql 30
end

Then /^I have (\d+) gists$/ do |count|
  @actual.count.should eql Integer(count)
end


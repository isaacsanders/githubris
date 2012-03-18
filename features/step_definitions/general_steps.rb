Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

Given /^@gist is a stale copy of the first gist$/ do
  @gist = Githubris::Gist.new :id => 1
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

Then /^I have that user$/ do
  @actual.should == test_user
end

Then /^I have the first gist$/ do
  @actual.should == test_gist
end

Then /^I have the newest version of the gist$/ do
  @actual.should == test_gist
end


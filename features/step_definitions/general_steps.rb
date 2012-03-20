Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

Given /^I have a client_id and a client_secret$/ do
  @client_id = test_client_id
  @client_secret = test_client_secret
end

Given /^@gist is a stale copy of the first gist$/ do
  @gist = Githubris::Gist.new :id => 1
end

Given /^I have a username and password$/ do
  @username = test_username
  @password = test_password
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

When /^I authenticate using Basic Auth$/ do
  @githubris.basic_auth @username, @password
end

When /^I authenticate using OAuth$/ do
  @githubris.oauth @client_id, @client_secret
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

Then /^I should be authenticated$/ do
  @githubris.authenticated?
end

Given /^@user is GithubrisTestUser$/ do
  @user = @githubris.find_user('GithubrisTestUser')
end

Given /^I have a client_id, a client_secret, and a code$/ do
  @client_id = test_client_id
  @client_secret = test_client_secret
  @code = 'code'
end

Given /^@gist is a stale copy of the first gist$/ do
  @gist = Githubris::Gist.new :id => 1
end

Given /^I have a username and password$/ do
  @username = test_username
  @password = test_password
end

Given /^I have a fake username and password$/ do
  @username = test_fake_username
  @password = test_password
end

Given /^there is no authenticated user$/ do
  Githubris::API.default_params({})
  Githubris::API.basic_auth(nil, nil)
end

Given /^there is an authenticated user$/ do
  @githubris.basic_auth test_username, test_password
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

When /^I authenticate using Basic Auth$/ do
  @githubris.basic_auth @username, @password
end

When /^I authenticate using OAuth$/ do
  oauth = @githubris.oauth @client_id, @client_secret
  oauth.access_token(@code)
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
  @githubris.should be_authenticated
end

Then /^I should not be authenticated$/ do
  @githubris.should_not be_authenticated
end

Then /^I should have some private and public gists$/ do
  @actual.all?(&:public?).should be_false
  @actual.any?(&:public?).should be_true
end

Given /^I have an instance of Githubris$/ do
  @githubris ||= lambda { Githubris.new }.call
end

Given /^I have an instance of Githubris::User$/ do
  @user ||= lambda do
    Githubris::User.new('GithubrisTestUser')
  end.call
end

When /^I access "([^"]*)"$/ do |api_code|
  @actual = binding.eval api_code
end

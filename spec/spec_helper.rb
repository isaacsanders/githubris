require 'rspec-spies'
require 'fakeweb'
require 'simplecov'
require 'githubris'

$:.push 'support'
require 'fixtures'
require 'fakeweb_responses'
require 'custom_matchers'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/pkg/'
  add_filter '/coverage/'
end

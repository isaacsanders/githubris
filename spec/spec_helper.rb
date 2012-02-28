require 'rspec-spies'
require 'fakeweb'
require 'simplecov'
require 'githubris'

require 'support/fixtures'
require 'support/fakeweb_responses'
require 'support/custom_matchers'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/pkg/'
  add_filter '/coverage/'
end

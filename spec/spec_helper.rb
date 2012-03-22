require 'rspec-spies'
require 'fakeweb'
require 'simplecov'
require 'githubris'

require 'support/fixtures'
require 'support/fakeweb_responses'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/pkg/'
  add_filter '/coverage/'
end

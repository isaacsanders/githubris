require 'rspec-spies'
require 'fakeweb'
require 'simplecov'
require 'githubris'
require 'pry'

require 'support/fixtures'
require 'support/vcr'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/pkg/'
  add_filter '/coverage/'
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/pkg/'
  add_filter '/coverage/'
end if ENV['COVERAGE']

require 'githubris'
require 'fakeweb'
require 'pry'

require 'support/fixtures'
require 'support/vcr'

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

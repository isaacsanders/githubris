RSpec::Matchers.define :all do |expected|

  match do |actual|
    @actual = actual
    @actual.all?(&@expectation)
  end
  chain :be_instance_of do |expected_klazz|
    @message = "be instances of #{expected_klazz}"
    @expectation = lambda do |actual|
      actual.instance_of? expected_klazz
    end
  end

  description do
    "all #{@message}"
  end
end

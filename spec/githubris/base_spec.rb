require 'spec_helper'

describe Githubris::Base do
  it 'has an attributes hash' do
    subject.instance_variable_get(:@attributes).should be_instance_of Hash
  end

  describe '#==' do
    it 'matches based on attributes' do
      object1 = described_class.new({:foo => 'bar'})
      object2 = described_class.new({:foo => 'bar'})
      object1.should == object2
    end
  end
end

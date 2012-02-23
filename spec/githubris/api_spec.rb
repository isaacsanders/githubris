require 'spec_helper'

describe Githubris::API do
  describe 'making calls' do
    subject { Githubris::API }

    before do
      Githubris::API.stub(:resolve)
    end

    it 'takes a single required data requirement' do
      lambda { subject.call({}) }.should_not raise_error
    end

    it 'takes multiple arguments' do
      Githubris::Config.stub(:[] => {:bar => {:baz => {}}})
      lambda {
        subject.call({}, :foo)
        subject.call({}, :foo, :bar)
        subject.call({}, :foo, :bar, :baz)
      }.should_not raise_error
    end

    it 'uses the config' do
      Githubris::Config.stub(:[] => {})
      subject.call({}, :foo)
      Githubris::Config.should have_received(:[]).with(:foo)
    end
  end
end

require 'spec_helper'

describe Githubris::API do
  describe 'making calls' do
    subject { Githubris::API }

    it 'takes multiple arguments' do
      Githubris::Config.stub(:[] => {:bar => {:baz => nil}})
      lambda {
        subject.call(:foo)
        subject.call(:foo, :bar)
        subject.call(:foo, :bar, :baz)
      }.should_not raise_error
    end

    it 'uses the config' do
      Githubris::Config.stub(:[])
      subject.call(:foo)
      Githubris::Config.should have_received(:[]).with(:foo)
    end

    it 'creates a new api call instance' do
      Githubris::Config.stub(:[] => {})
      subject.call(:foo).should be_instance_of Hash
    end
  end

  describe 'resolving calls' do
    it 'calls github' do
      Githubris::API.new({method: 'post', uri: '/foo/bar'}).resolve
      FakeWeb.last_request.should_not be_nil
    end
  end
end

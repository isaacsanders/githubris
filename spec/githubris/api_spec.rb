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
      Githubris::Config.stub(:[] => stub("2nd level",:[] => {}))
      subject.call(:foo)
      Githubris::Config.should have_received(:[]).with(:foo)
      subject.call(:foo, :bar)
      Githubris::Config.[].should have_received(:[]).with(:bar)
    end

    it 'hits only github' do
      FakeWeb.allow_net_connect = 'api.github.com'
      subject.call :foo
      FakeWeb.last_request.should_not be_nil
      lambda { Net::HTTP.get('example.com', '/') }.should raise_error
    end


  end
end

require 'spec_helper'

describe Githubris::API do
  describe 'making calls' do
    subject { Githubris::API }

    before do
      Githubris::API.stub(:resolve)
    end

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
  end
end

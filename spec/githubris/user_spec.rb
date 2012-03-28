require 'spec_helper'

describe Githubris::User do
  it 'is initialized with an attributes hash' do
    attributes = {foo: 'bar'}
    lambda { Githubris::User.new attributes }.should_not raise_error
  end

  describe '#==' do
    it 'matches based on attributes' do
      user1 = Githubris::User.new({foo: 'bar'})
      user2 = Githubris::User.new({foo: 'bar'})
      user1.should == user2
    end
  end

  describe '#gists' do
    it 'gets a list of gists' do
      described_class.new(:login => 'GithubrisTestUser').gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end
end

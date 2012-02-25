require 'spec_helper'

describe Githubris do
  describe '#authenticate' do
    it 'authenticates via Basic Auth' do
      Githubris::API.stub(:basic_auth)
      subject.authenticate('username', 'password')
      Githubris::API.should have_received(:basic_auth).with('username', 'password')
    end

    it 'sets the authenticated user' do
      subject.authenticate('username', 'password')
      subject.authenticated_user.should_not be_nil
    end
  end

  describe '#find_user' do
    it 'requests gets user from githubris api' do
      user = Githubris::User.new(login: "frank")
      Githubris::API.stub(:get_user).and_return(user)
      subject.find_user("frank").should == user
    end
  end
end

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
      Githubris::API.any_instance.stub(:get_user).and_return(user)
      subject.find_user("frank").should == user
    end

    it 'returns a user' do
      subject.find_user('frank').should be_instance_of Githubris::User
    end
  end

  describe '#public_gists' do

    it 'uses the API' do
      Githubris::API.any_instance.stub(:get_public_gists)
      subject.public_gists
      subject.instance_variable_get(:@api).should have_received(:get_public_gists).with({})
    end

    context 'with no arguments' do
      it 'should contain only gists' do
        subject.public_gists.each do |gist|
          gist.should be_instance_of Githubris::Gist
        end
      end
    end
  end
end

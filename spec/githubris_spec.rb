require 'spec_helper'

describe Githubris do
  context 'class methods' do
    describe '.logout' do
      it 'drops any authenticated user' do
        Githubris.logout
        Githubris.authenticated_user.should be_nil
      end
    end

    describe '.login' do
      before do
        Githubris.logout
      end

      it 'takes a username and password' do
        lambda do
          Githubris.login('username', 'password')
        end.should_not raise_error
      end

      it 'authenticates via Basic Auth' do
        Githubris::API.stub(:basic_auth)
        Githubris.login('username', 'password')
        Githubris::API.should have_received(:basic_auth).with('username', 'password')
      end

      it 'sets the authenticated user' do
        Githubris.login('username', 'password')
        Githubris.authenticated_user.should_not be_nil
      end
    end
  end
end

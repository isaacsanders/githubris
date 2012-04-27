require 'spec_helper'

describe Githubris::API::User do
  let(:api) { Githubris::API.new }
  subject { api }
  use_vcr_cassette

  describe '#get_authenticated_user' do
    context 'without credentials' do

      it 'raises a Githubris::Error::RequiresAuthentication' do
        lambda do
          subject.get_authenticated_user
        end.should raise_error(Githubris::Error::RequiresAuthentication)
      end
    end
  end

  describe '#get_user' do

    subject { api.get_user('GithubrisTestUser') }
    it 'takes a login' do
      lambda do
        api.get_user('GithubrisTestUser')
      end.should_not raise_error
    end

    it 'returns a user object' do
      subject.should be_instance_of Githubris::User
    end
  end

  describe '#patch_user' do
    it 'saves changes to github' do
      lambda do
        api.basic_auth('GithubrisTestUser', 'password')
        user = api.get_authenticated_user

        user.company = 'Acme, Inc.'
        user.save

        user = nil

        user = api.get_user('GithubrisTestUser')

        user.company.should == 'Acme, Inc.'
      end.should_not raise_error
    end
  end
end

require 'spec_helper'

describe Githubris::API::User do
  let(:api) { Githubris::API.new }
  subject { api }

  describe '#get_authenticated_user' do
    context 'without credentials' do
      use_vcr_cassette

      it 'raises a Githubris::Error::RequiresAuthentication' do
        lambda do
          subject.get_authenticated_user
        end.should raise_error(Githubris::Error::RequiresAuthentication)
      end
    end
  end

  describe '#get_user' do
    use_vcr_cassette

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
end

require 'spec_helper'

describe Githubris::API do
  let(:api) { Githubris::API.new }

  describe '#authenticated?' do
    it 'checks for an authenticated user' do
      subject.should_receive(:get_authenticated_user)
      subject.authenticated?
    end

    context 'when authenticated with good credentials' do
      subject do
        api.basic_auth('GithubrisTestUser', 'password')
        api.authenticated?
      end

      it { should be_true }
    end

    context 'when authenticated with bad credentials' do
      subject do
        api.basic_auth('GithubrisTestFakeUser', 'password')
        api.authenticated?
      end

      it { should be_false }
    end

    context 'when there are no credentials' do
      subject do
        api.authenticated?
      end

      it { should be_false }
    end
  end

  describe '#oauth' do
    it 'returns a Githubris::OAuth' do
      client_id = 'client_id'
      client_secret = 'client_secret'
      subject.oauth(client_id, client_secret).should be_instance_of Githubris::OAuth
    end

    it 'returns a Githubris::OAuth initialized with the client id and secret' do
      client_id = 'client_id'
      client_secret = 'client_secret'
      Githubris::OAuth.should_receive(:new).with(client_id, client_secret)
      subject.oauth(client_id, client_secret)
    end

    it 'can take options' do
      client_id = 'client_id'
      client_secret = 'client_secret'
      Githubris::OAuth.should_receive(:new).with(client_id, client_secret)
      subject.oauth(client_id, client_secret)
    end
  end

  describe '#post_oauth_access_token' do
    it 'takes params' do
      lambda do
        subject.post_oauth_access_token({})
      end.should_not raise_error
    end
    it 'returns a string' do
      subject.post_oauth_access_token({}).should be_instance_of String
    end
  end
end

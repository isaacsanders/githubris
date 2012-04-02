require 'spec_helper'

describe Githubris::API do
  let(:api) { Githubris::API.new }

  describe '#authenticated?' do
    it 'checks for an authenticated user' do
      subject.should_receive(:get_authenticated_user)
      subject.authenticated?
    end

    context 'when authenticated with good credentials' do
      before do
        FakeWeb.register_uri(:get, 'https://api.github.com/user?', :body => File.open("spec/support/user.json"){|f| f.read })
      end

      after do
        FakeWeb.clean_registry
      end

      subject do
        api.basic_auth('GithubrisTestUser', 'password')
        api.authenticated?
      end

      use_vcr_cassette

      it { should be_true }
    end

    context 'when authenticated with bad credentials' do
      use_vcr_cassette

      subject do
        api.basic_auth('GithubrisTestFakeUser', 'password')
        api.authenticated?
      end

      it { should be_false }
    end

    context 'when there are no credentials' do
      use_vcr_cassette

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
    use_vcr_cassette

    before do
      access_token_response =<<-RESPONSE
HTTP/1.1 200 OK
Server: nginx/1.0.13
Date: Wed, 21 Mar 2012 12:54:41 GMT
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Connection: keep-alive
Status: 200 OK
ETag: "fa6a87d35864200004d1eff50d685301"
X-Frame-Options: deny
X-Runtime: 14
Content-Length: 71
Cache-Control: private, max-age=0, must-revalidate
Strict-Transport-Security: max-age=2592000

access_token=1663860ddbbb9137119ff03ef2a9d819bbce4d0e&token_type=bearer
RESPONSE
      FakeWeb.register_uri(:post, /github.com\/login\/oauth\/access_token/, :response => access_token_response)
    end

    after do
      FakeWeb.clean_registry
    end

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

require 'spec_helper'

describe Githubris::OAuth do
  let(:oauth) { described_class.new(client_id, client_secret) }
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }

  describe '#initialize' do
    it 'requires a client_id and a client_secret' do
      lambda do
        described_class.new(client_id, client_secret)
      end.should_not raise_error
    end
  end

  describe '#request_access_url' do
    subject { oauth.request_access_url }
    let(:request_access_url_pattern) do
      /https:\/\/github.com\/login\/oauth\/authorize\?.*client_id=#{client_id}/
    end

    it { should match request_access_url_pattern }

    it 'takes a list of scopes and a redirect_uri, optionally' do
      redirect_uri = 'https://isaacbfsanders.com'
      url = oauth.request_access_url(:scopes => [:user, :public_repo, :repo, :gist],
                                     :redirect_uri => redirect_uri)
      url.should match request_access_url_pattern
      url.should match /scopes=user,public_repo,repo,gist/
      url.should match /redirect_uri=#{URI.encode(redirect_uri)}/
    end
  end

  describe '#access_token' do
    it 'requires a code parameter' do
      lambda do
        oauth.access_token('code')
      end.should_not raise_error
    end

    it 'returns a string' do
      oauth.access_token('code').should be_kind_of String
    end
  end
end

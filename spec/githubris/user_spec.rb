require 'spec_helper'

describe Githubris::User do
  use_vcr_cassette

  describe '#emails' do
    it 'raises an error when not authenticated' do
      lambda do
        described_class.new.emails
      end.should raise_error Githubris::Error
    end
  end

  describe '#gists' do
    it 'gets a list of gists' do
      gists = described_class.new(:login => 'GithubrisTestUser').gists
      gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end

  describe '#reload' do
    context 'on a user with a login' do
      subject { described_class.new :login => login }
      let(:login) { 'GithubrisTestUser' }

      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end

    context 'on a user without a login' do
      it 'raises an error' do
        lambda do
          subject.reload
        end.should raise_error Githubris::Error::NotFound
      end
    end
  end

  context 'on an authenticated user' do
    subject do
      ghr = Githubris.new
      ghr.basic_auth 'GithubrisTestUser', 'password'
      ghr.authenticated_user
    end

    describe '#starred_gists' do
      it 'returns a list of starred gists' do
        subject.starred_gists.each do |gist|
          gist.should be_instance_of Githubris::Gist
        end
      end
    end

    describe '#emails' do
      it 'returns a list of email addresses' do
        subject.emails.each do |address|
          address.should match /@/
        end
      end
    end
  end
end

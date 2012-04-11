require 'spec_helper'

describe Githubris::User do
  describe '#gists' do
    use_vcr_cassette

    it 'gets a list of gists' do
      gists = described_class.new(:login => 'GithubrisTestUser').gists
      gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end

  describe '#starred_gists' do

    context 'on an authenticated user' do

      subject do
        ghr = Githubris.new
        ghr.basic_auth 'GithubrisTestUser', 'password'
        VCR.use_cassette 'Githubris_API/_authenticated_/when_authenticated_with_good_credentials' do
          ghr.authenticated_user
        end
      end

      use_vcr_cassette

      it 'returns a list of starred gists' do
        subject.starred_gists.each do |gist|
          gist.should be_instance_of Githubris::Gist
        end
      end
    end
  end

  describe '#reload' do

    context 'on a user with a login' do
      use_vcr_cassette

      subject { described_class.new :login => login }
      let(:login) { 'GithubrisTestUser' }

      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end

    context 'on a user without a login' do
      use_vcr_cassette

      it 'raises an error' do
        lambda do
          subject.reload
        end.should raise_error Githubris::Error::NotFound
      end
    end
  end
end

require 'spec_helper'

describe Githubris::Gist do
  let(:id) { 1 }
  subject { described_class.new :id => id }

  context 'on a gist with an id' do
    use_vcr_cassette

    describe '#reload' do
      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end
  end

  context 'given a gist full of data' do
    use_vcr_cassette

    describe '#user' do
      it 'returns a user' do
        subject.reload
        subject.user.should be_instance_of Githubris::User
      end
    end
  end

  describe '#save' do
    use_vcr_cassette

    it 'for a public, anonymous gist' do
      gist = described_class.new :public => true, :files => {'gistfile.txt' => {:content => 'foobar'}}
      lambda { gist.save }.should_not raise_error
    end

    context 'when authenticated' do

      let(:api) { Githubris::API.new }

      before do
        api.basic_auth('GithubrisTestUser', 'password')
      end

      it 'for a gist by an authenticated user' do
        gist = described_class.new :_api => api, :public => true, :files => {'gistfile.txt' => {:content => 'foobar'}}
        lambda { gist.save }.should_not raise_error
        gist.user.login.should == 'GithubrisTestUser'
      end
    end
  end
end

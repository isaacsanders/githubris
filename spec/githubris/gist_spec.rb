require 'spec_helper'

describe Githubris::Gist do
  use_vcr_cassette

  describe '#new?' do
    it 'seems new if there are issues when reloading' do
      gist_without_id = Githubris::Gist.new
      gist_without_id.should be_new
    end

    it 'seems to not be new if there are no issues' do
      gist = Githubris::Gist.new :id => 1
      gist.should_not be_new
    end
  end

  context 'on a gist with an id' do
    subject { described_class.new :id => id }
    let(:id) { 1 }

    describe '#reload' do
      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end

    context 'given a gist full of data' do
      describe '#user' do
        it 'returns a user' do
          subject.reload
          subject.user.should be_instance_of Githubris::User
        end
      end
    end
  end

  describe '#save' do
    it 'for a public, anonymous gist' do
      gist = described_class.new :public => true, :files => {'gistfile.txt' => {:content => 'foobar'}}
      lambda { gist.save }.should_not raise_error
    end
  end

  context 'when authenticated' do
    let(:api) { Githubris::API.new }
    let(:user) { api.get_authenticated_user }

    before do
      api.basic_auth 'GithubrisTestUser', 'password'
      api.should be_authenticated
    end

    describe '#star!' do
      let(:gist) { Githubris::Gist.new(:id => 1, :_api => api).reload }

      it 'it stars the gist' do
        gist.star!
        gist.should be_starred
      end
    end

    describe '#unstar!' do
      let(:gist) { api.get_authenticated_user.starred_gists.first }

      it 'it unstars the gist' do
        gist.unstar!
        gist.should be_unstarred
      end
    end

    describe '#save' do
      context 'creating a file' do
        it 'for a gist by an authenticated user' do
          gist = described_class.new :_api => api, :public => true, :files => {'gistfile.txt' => {:content => 'foobar'}}
          lambda { gist.save }.should_not raise_error
          gist.user.login.should == 'GithubrisTestUser'
        end

        it 'for a private gist by an authenticated user' do
          gist = described_class.new :_api => api, :public => false, :files => {'gistfile.txt' => {:content => 'foobar'}}
          lambda { gist.save }.should_not raise_error
          gist.user.login.should == 'GithubrisTestUser'
        end
      end

      context 'editing a file' do
        xit 'can be used to edit a file' do
          gist = api.get_authenticated_user.gists.last
          expected_id = gist.id
          gist.files['gistfile.txt'] = {}
          file = gist.files['gistfile.txt']
          content = <<-EOF
            lorem ipsum, all the time.
          EOF

          file[:content] = content
          lambda { gist.save }.should_not raise_error

          file[:content].should == content
          gist.id.should == expected_id
        end
      end
    end
  end
end

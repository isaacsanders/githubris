require 'spec_helper'

describe Githubris::API::Gist do
  use_vcr_cassette

  subject do
    Githubris::API.new
  end

  describe '#get_user_gists' do
    let(:login) {'GithubrisTestUser'}

    it 'gets /users/:username/gists' do
      subject.should_receive(:user_gists_path).with(login).and_return('/users/GithubrisTestUser/gists')
      user_public_gists = subject.get_user_gists(login)
    end
  end

  describe '#get_public_gists' do
    it 'returns an array of gists' do
      subject.get_public_gists.should be_instance_of Array
      subject.get_public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end

  describe '#get_gist' do
    let(:id) { 1 }
    it 'is a Githubris::Gist' do
      subject.get_gist(id).should be_instance_of Githubris::Gist
    end
  end
end

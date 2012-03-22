require 'spec_helper'

describe Githubris::API::Gist do
  subject do
    Githubris::API.new
  end

  after do
    Githubris::API.default_options.delete(:basic_auth)
    Githubris::API.default_options.delete(:default_params)
    Githubris::API.default_options.delete(:query)
  end

  describe '#get_user_public_gists' do
    let(:login) {'GithubrisTestUser'}

    it 'gets /users/:username/gists' do
      subject.stub(:user_gists_path => '/users/GithubrisTestUser/gists')
      user_public_gists = subject.get_user_public_gists(login)
      subject.should have_received(:user_gists_path).with(login)
    end

    context 'given a user with 2 gists' do
      it 'returns 2 gists by the given user' do
        user_public_gists = subject.get_public_gists(:user => login)
        user_public_gists.should have(2).items
        user_public_gists.each do |gist|
          gist.should be_instance_of Githubris::Gist
        end
      end
    end

  end

  describe '#get_public_gists' do
    it 'returns an array of gists' do
      subject.get_public_gists.should be_instance_of Array
      subject.get_public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end

    it 'accepts an options hash' do
      lambda do
        subject.get_public_gists({:foo => 'bar'})
      end.should_not raise_error
    end
  end

  describe '#get_gist' do
    let(:id) { 1 }
    it 'is a Githubris::Gist' do
      subject.get_gist(id).should be_instance_of Githubris::Gist
    end
  end
end

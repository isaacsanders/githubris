require 'spec_helper'

describe Githubris::API::Gist do
  subject do
    Githubris::API.new
  end

  describe '#get_user_public_gists' do
    let(:login) {'GithubrisTestUser'}

    it 'gets /users/:username/gists' do
      subject.stub(:user_gists_path => '/users/GithubrisTestUser/gists')
      user_public_gists = subject.get_user_public_gists(login)
      subject.should have_received(:user_gists_path).with(login)
    end

    it 'retrieves the full user' do
      subject.stub(:get_user)
      subject.get_public_gists(user: login)
      subject.should have_received(:get_user).with(login)
    end

    context 'given a user with 2 gists' do
      it 'returns 2 gists by the given user' do
        user_public_gists = subject.get_public_gists(user: login)
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
        subject.get_public_gists({foo: 'bar'})
      end.should_not raise_error
    end

    context 'given a page option' do
      it 'returns an array of 30 gists from that page' do
        page_one_gists = subject.get_public_gists(page: 1)
        page_two_gists = subject.get_public_gists(page: 2)
        page_one_gists.should have(30).items
        page_two_gists.should have(30).items
      end
    end

    context 'given a user option' do
      it 'delegates to #get_user_public_gists' do
        login = 'GithubrisTestUser'
        subject.should_receive(:get_user_public_gists).with(login)
        subject.get_public_gists(user: login)
      end
    end
  end
end

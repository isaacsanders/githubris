require 'spec_helper'

describe Githubris::API do
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
        (page_two_gists == page_one_gists).should be_false
      end
    end

    context 'given a user option' do
      it 'hits /users/:username/gists' do
        username = 'GithubrisTestUser'
        user_public_gists = subject.get_public_gists(user: username)
        FakeWeb.last_request.path.should match /users\/#{username}\/gists/
      end

      context 'given a user with 2 gists' do
        it 'returns 2 gists by the given user' do
          username = 'GithubrisTestUser'
          user_public_gists = subject.get_public_gists(user: username)
          user_public_gists.should have(2).items
          user_public_gists.each do |gist|
            gist.should be_instance_of Githubris::Gist
          end
        end
      end
    end
  end
end

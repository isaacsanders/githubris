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

  describe '#get_user_gists' do
    use_vcr_cassette

    let(:login) {'GithubrisTestUser'}

    it 'gets /users/:username/gists' do
      subject.stub(:user_gists_path => '/users/GithubrisTestUser/gists')
      user_public_gists = subject.get_user_gists(login)
      subject.should have_received(:user_gists_path).with(login)
    end
  end

  describe '#get_public_gists' do
    use_vcr_cassette

    it 'returns an array of gists' do
      subject.get_public_gists.should be_instance_of Array
      subject.get_public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end

  describe '#get_gist' do
    use_vcr_cassette

    let(:id) { 1 }
    it 'is a Githubris::Gist' do
      subject.get_gist(id).should be_instance_of Githubris::Gist
    end
  end
end

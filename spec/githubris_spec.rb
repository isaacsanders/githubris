require 'spec_helper'

describe Githubris do
  describe '#basic_auth' do
    let(:password) { 'password' }

    context 'with valid credentials' do
      let(:username) { 'GithubrisTestUser' }

      it 'authenticates via the API' do
        Githubris::API.any_instance.should_receive(:basic_auth).with(username, password)
        subject.basic_auth(username, password)
      end
    end
  end

  describe '#oauth' do
    let(:client_id) { 'client_id' }
    let(:client_secret) { 'client_secret' }

    it 'creates an Githubris::OAuth object' do
      subject.oauth(client_id, client_secret).should be_instance_of Githubris::OAuth
    end
  end

  describe '#authenticated?' do
    it 'delegates to the API' do
      Githubris::API.any_instance.should_receive :authenticated?
      subject.authenticated?
    end
  end

  describe '#find_user' do
    use_vcr_cassette

    it 'requests gets user from githubris api' do
      user = Githubris::User.new(:login => 'GithubrisTestUser')
      Githubris::API.any_instance.stub(:get_user).and_return(user)
      subject.find_user('GithubrisTestUser').should == user
    end

    it 'returns a user' do
      subject.find_user('GithubrisTestUser').should be_instance_of Githubris::User
    end
  end

  describe '#public_gists' do
    use_vcr_cassette

    it 'should contain only gists' do
      subject.public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end

    it 'delegates and passes the options hash to the API' do
      Githubris::API.any_instance.stub(:get_public_gists)
      subject.public_gists({:foo => 'bar'})
      subject.instance_variable_get(:@api).should have_received(:get_public_gists).with({:foo => 'bar'})
    end
  end

  describe '#find_gist' do
    let(:id) { 1 }
    subject { Githubris.new.find_gist(id) }
    use_vcr_cassette

    it 'returns a gist' do
      subject.should be_instance_of Githubris::Gist
    end
  end
end

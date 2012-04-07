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
    use_vcr_cassette

    let(:id) { 1 }

    it 'takes a gist\'s id' do
      lambda do
        subject.find_gist(id)
      end.should_not raise_error
    end

    it 'hits the API' do
      Githubris::API.any_instance.should_receive(:get_gist).with(id)
      subject.find_gist(id)
    end

    context 'the gist it returns' do
      subject { Githubris.new.find_gist(id) }

      it 'has the same id that was passed in' do
        subject.should be_instance_of Githubris::Gist
        subject.id.should == id
      end

      it 'has a user' do
        lambda do
          subject.user.should be_instance_of Githubris::User
        end.should_not raise_error
      end
    end
  end
end

require 'spec_helper'

describe Githubris do
  describe '#authenticate' do
    before do
      Githubris::API.stub(:basic_auth => Githubris::User.new)
      subject.authenticate('username', 'password')
    end

    it 'authenticates via Basic Auth' do
      Githubris::API.should have_received(:basic_auth).with('username', 'password')
    end

    it 'sets the authenticated user' do
      subject.authenticated_user.should_not be_nil
    end
  end

  describe '#find_user' do
    it 'requests gets user from githubris api' do
      user = Githubris::User.new(:login => "frank")
      Githubris::API.any_instance.stub(:get_user).and_return(user)
      subject.find_user("frank").should == user
    end

    it 'returns a user' do
      subject.find_user('frank').should be_instance_of Githubris::User
    end
  end

  describe '#public_gists' do
    it 'should contain only gists' do
      subject.public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end

    it 'can take an options hash' do
      lambda { subject.public_gists(:foo => 'bar') }.should_not raise_error
    end

    it 'delegates and passes the options hash to the API' do
      Githubris::API.any_instance.stub(:get_public_gists)
      subject.public_gists({:foo => 'bar'})
      subject.instance_variable_get(:@api).should have_received(:get_public_gists).with({foo: 'bar'})
    end
  end

  describe '#find_gist' do
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

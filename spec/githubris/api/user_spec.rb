require 'spec_helper'

describe Githubris::API::User do
  let(:api) { Githubris::API.new }

  describe '#get_user' do
    subject { api.get_user('login') }
    it 'takes a login' do
      lambda do
        api.get_user('login')
      end.should_not raise_error
    end

    it 'returns a user object' do
      subject.should be_instance_of Githubris::User
    end
  end
end

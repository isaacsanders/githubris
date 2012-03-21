require 'spec_helper'

describe Githubris::API::User do
  let(:api) { Githubris::API.new }
  subject { api }

  describe '#get_authenticated_user' do

    context 'without credentials' do
      before do
        Githubris::API.default_options.delete(:basic_auth)
      end

      it 'raises a Githubris::Error' do
        lambda do
          subject.get_authenticated_user
        end.should raise_error(Githubris::Error)
      end
    end
  end

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

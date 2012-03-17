require 'spec_helper'

describe Githubris::User do
  it 'is initialized with an attributes hash' do
    attributes = {foo: 'bar'}
    lambda { Githubris::User.new attributes }.should_not raise_error
  end

  describe '#public_gists' do
    it 'hits the API' do
      Githubris::API.any_instance.should_receive(:get_user_public_gists)
      user = Githubris::User.new
      user.public_gists
    end
  end
end

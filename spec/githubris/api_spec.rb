require 'spec_helper'

describe Githubris::API do
  describe '#get_public_gists' do
    it 'uses the builder' do
      Githubris::Builder.any_instance.stub(:build_gists)
      subject.get_public_gists
      subject.instance_variable_get(:@builder).should have_received(:build_gists)
    end
  end
end

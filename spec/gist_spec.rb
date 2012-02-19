require 'spec_helper'

describe Githubris::Gist do
  context 'class methods' do
    subject { Githubris::Gist }
    it_behaves_like 'a collection API'
  end

  context 'instance methods' do
    it_behaves_like 'a commentable API'
  end
end

require 'spec_helper'

describe Githubris::Gist do

  context 'instance methods' do
    subject { gist }
    let(:gist) { Githubris::Gist.new }

    it 'new gists are created now' do
      DateTime.stub(:now => DateTime.new(2012, 12, 21, 12, 0, 0))
      gist.created_at.should eql DateTime.now
    end

    context 'Gist owned by Isaac' do
      subject { Githubris::Gist.new user: user }
      let(:user) { Githubris::User.new }
      its(:user) { should eql user }
    end


    describe 'a gist without files' do
      its(:files) { should be_empty }
    end

    describe 'a gist created with a file' do
      subject do
        Githubris::Gist.new(files: [stub])
      end

      its(:files) { should have(1).items }
    end
  end
end

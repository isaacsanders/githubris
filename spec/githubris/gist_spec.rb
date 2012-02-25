require 'spec_helper'

describe Githubris::Gist do
  describe '.public_gists' do
    context 'when there are a few gists' do
      it 'is an array of gists' do
        Githubris::API.stub(:call => [Githubris::Gist.new, Githubris::Gist.new])
        Githubris::Gist.public_gists.each do |gist|
          gist.should be_instance_of Githubris::Gist
        end
      end
    end
  end

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

      describe 'saving' do
        it 'gets sent to github' do
          Githubris::API.stub(:save_gist)
          subject.save
          Githubris::API.should have_received(:save_gist).with(subject)
        end
      end
    end
  end
end

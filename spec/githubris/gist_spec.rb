require 'spec_helper'

describe Githubris::Gist do
  context 'class methods' do
    subject { Githubris::Gist }
    describe '.public_gists' do
      subject { Githubris::Gist.public_gists }

      before do
        Githubris::API.stub(:call =>
                            Githubris::SpecHelper.gist_collection_data)
      end

      context 'when there are a few gists' do
        its(:length) { should be_greater_than 1 }
        it 'is an array of gists' do
          subject.each do |gist|
            gist.should be_instance_of Githubris::Gist
          end
        end
      end
    end

    describe 'build' do

      context 'when passed a collection of gist data' do
        subject do
          Githubris::Gist.build Githubris::SpecHelper.gist_collection_data
        end

        it { should be_instance_of Array }

        it 'is an array of gists' do
          subject.each do |gist|
            gist.should be_instance_of Githubris::Gist
          end
        end

        it 'each gist has a user defined' do
          subject.each do |gist|
            gist.user.should be_instance_of Githubris::User
          end
        end
      end

      context 'when passed the data for a single gist' do
        subject do
          Githubris::Gist.build Githubris::SpecHelper.gist_data
        end

        it { should be_instance_of Githubris::Gist }
        its(:user) { should be_instance_of Githubris::User }

      end

      context 'when passed a specific gist' do
        let(:gist) do
          Githubris::SpecHelper.gist_data
        end

        subject do
          Githubris::Gist.build gist
        end

        it 'is public' do
          subject.should be_public
        end

        it 'has 5 comments' do
          subject.comments.length.should eql 5
        end

        its(:description) { should eql 'the meaning of gist' }

        it 'was created at 6:17:13 on July 15, 2008' do
          subject.created_at.should eql DateTime.new(2008, 7, 15, 18, 17, 13)
        end

        it 'was updated at 2:58:22 on Feburary 22, 2011' do
          subject.updated_at.should eql DateTime.new(2011, 2, 22, 2, 58, 22)
        end
      end
    end
  end

  context 'instance methods' do
    let(:gist) { Githubris::Gist.new }

    its(:user) { should be_instance_of Githubris::User }

    it 'new gists are created now' do
      DateTime.stub(:now => DateTime.new(2012, 12, 21, 12, 0, 0))
      gist.created_at.should eql DateTime.now
    end

    it 'new gists belong to the authenticated user' do
      Githubris.stub(:authenticated_user => 'foobar')
      gist.user.should eql Githubris.authenticated_user
    end

    context 'with no authenticated user' do

      it 'is nil' do
        gist.user.should be_nil
      end
    end

    context 'Gist owned by Isaac' do
      subject { Githubris::Gist.new user: user }
      let(:user) { stub('User', name: 'Isaac Sanders') }
      its(:user) { should eql user }
    end


    describe 'a gist without files' do
      its(:files) { should be_empty }
    end

    describe 'a gist created with a file' do
      subject do
        Githubris::Gist.new(files: [Githubris::Gist::File.new])
      end

      it 'has one file' do
        subject.files.count.should eql 1
      end

      its(:files) { should all.be_instance_of Githubris::Gist::File }

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

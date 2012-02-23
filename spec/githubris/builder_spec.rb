require 'githubris/builder'
require 'spec_helper'

describe Githubris::GistBuilder do
  describe 'build' do
    context 'when passed a collection of gist data' do
      subject do
        Githubris::GistBuilder.build Githubris::SpecHelper.gist_collection_data
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
        Githubris::GistBuilder.build Githubris::SpecHelper.gist_data
      end

      it { should be_instance_of Githubris::Gist }
      its(:user) { should be_instance_of Githubris::User }

    end

    context 'when passed a specific gist' do
      let(:gist) do
        Githubris::SpecHelper.gist_data
      end

      subject do
        Githubris::GistBuilder.build gist
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

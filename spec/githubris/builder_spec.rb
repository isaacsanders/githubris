require 'githubris/builder'
require 'spec_helper'

describe Githubris::GistBuilder do
  describe 'build' do
    let(:gist_data) { Githubris::SpecHelper.gist_data }

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
    end

    context 'when passed the data for a single gist' do
      subject { Githubris::GistBuilder.build gist_data }

      it                { should be_instance_of Githubris::Gist }
      it                { should be_public }
      its(:user)        { should be_instance_of Githubris::User }
      its(:description) { should be_instance_of String }
      its(:created_at)  { should be_instance_of DateTime }
      its(:updated_at)  { should be_instance_of DateTime }
      its(:comments)    { should be_instance_of Array }
      its(:files)       { should be_instance_of Array }
      its(:url)         { should be_kind_of URI }
    end

    context 'when passed a specific gist' do
      subject { Githubris::GistBuilder.build gist_data }

      it 'is public' do
        subject.should be_public
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

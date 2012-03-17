require 'spec_helper'

describe Githubris::Builder::Gist do
  subject { Githubris::Builder::Gist.new.build gist_data }
  let(:gist_data) { Githubris::SpecHelper.gist_data }

  context 'schema' do

    it                { should be_instance_of Githubris::Gist }
    its(:url)         { should be_kind_of URI }
    its(:id)          { should be_instance_of Fixnum }
    its(:description) { should be_instance_of String }
    it                { should be_public }
    its(:created_at)  { should be_instance_of DateTime }
    its(:updated_at)  { should be_instance_of DateTime }
    its(:comments)    { should be_instance_of Array }
    its(:files)       { should be_instance_of Array }
  end

  context 'when passed a specific gist' do

    it 'is public' do
      subject.should be_public
    end

    its(:id) { should eql 1 }

    its(:description) { should eql 'the meaning of gist' }

    it 'was created at 6:17:13 on July 15, 2008' do
      subject.created_at.should eql DateTime.new(2008, 7, 15, 18, 17, 13)
    end

    it 'was updated at 2:58:22 on Feburary 22, 2011' do
      subject.updated_at.should eql DateTime.new(2011, 2, 22, 2, 58, 22)
    end
  end
end

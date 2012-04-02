require 'spec_helper'

describe Githubris::Gist do

  context 'when passed a specific gist' do
    subject { Githubris::Gist.new gist_attributes }
    let(:gist_attributes) { Githubris::Builder.new.build gist_data }
    let(:gist_data) { Githubris::SpecHelper.gist_data }


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

    its(:url)         { should be_kind_of URI }
    its(:id)          { should be_instance_of Fixnum }
    its(:description) { should be_instance_of String }
    it                { should be_public }
    its(:created_at)  { should be_instance_of DateTime }
    its(:updated_at)  { should be_instance_of DateTime }
    its(:comments)    { should be_instance_of Array }
    its(:files)       { should be_instance_of Array }

  end

  it 'new gists are created now' do
    DateTime.stub(:now => DateTime.new(2012))
    subject.created_at.should eql DateTime.now
  end

  context 'Gist owned by Isaac' do
    subject { Githubris::Gist.new :user => user }
    let(:user) { Githubris::User.new }
    its(:user) { should eql user }
  end

  describe 'a gist without files' do
    subject { Githubris::Gist.new }
    its(:files) { should be_empty }
  end

  describe 'a gist created with a file' do
    subject do
      Githubris::Gist.new(:files => {:stub => stub})
    end

    its(:files) { should have(1).items }
  end

  describe '#==' do
    it 'checks the attributes of each object' do
      subject.should == Githubris::Gist.new
      subject.should_not == stub
    end
  end

  describe '#reload' do

    it 'errors without an id' do
      lambda do
        subject.reload
      end.should raise_error
    end

    context 'on a gist with an id' do
      use_vcr_cassette

      subject { Githubris::Gist.new :id => id }
      let(:id) { 1 }

      it 'hits the API' do
        Githubris::API.any_instance.should_receive(:get_gist).with(id)
        subject.reload
      end

      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end
  end
end

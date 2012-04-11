require 'spec_helper'

describe Githubris::Gist do
  context 'any gist' do
    use_vcr_cassette

    subject do
      gist = Githubris::Gist.new :id => 1
      gist.reload
    end
    its(:url)         { should be_kind_of URI }
    its(:id)          { should be_instance_of Fixnum }
    its(:description) { should be_instance_of String }
    it                { should be_public }
    its(:created_at)  { should be_instance_of DateTime }
    its(:updated_at)  { should be_instance_of DateTime }
    its(:comments)    { should be_instance_of Array }
    its(:files)       { should be_instance_of Hash }
  end

  describe '#==' do
    it 'checks the attributes of each object' do
      subject.should == described_class.new
      subject.should_not == stub
    end
  end

  describe '#publicize' do
    it 'makes the gist public' do
      subject.publicize
      subject.should be_public
    end
  end

  describe '#privatize' do
    it 'makes the gist private' do
      subject.privatize
      subject.should_not be_public
    end
  end

  describe '#reload' do
    context 'on a gist with an id' do
      use_vcr_cassette

      subject { described_class.new :id => id }
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

  describe '#save' do
    use_vcr_cassette

    it 'it must have be public or not, and it must have files' do
      gist = described_class.new :public => true, :files => {'gistfile.txt' => {:content => 'foobar'}}
      lambda { gist.save }.should_not raise_error
    end
  end
end

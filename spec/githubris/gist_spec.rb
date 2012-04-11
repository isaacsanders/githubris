require 'spec_helper'

describe Githubris::Gist do
  let(:id) { 1 }
  subject { described_class.new :id => id }

  context 'on a gist with an id' do
    use_vcr_cassette

    describe '#reload' do
      it 'returns the same object' do
        obj_id = subject.object_id
        subject.reload.object_id.should == obj_id
      end
    end
  end

  context 'given a gist full of data' do
    use_vcr_cassette

    describe '#user' do
      it 'returns a user' do
        subject.reload
        subject.user.should be_instance_of Githubris::User
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

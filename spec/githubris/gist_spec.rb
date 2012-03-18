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
    let(:this) { Githubris::Gist.new }
    subject { this == other }

    context 'the other\'s class is Githubris::Gist' do
      let(:other) { Githubris::Gist.new }

      context 'the gists have the same creation times' do
        before { Githubris::Gist.any_instance.stub(:created_at => stub) }

        context 'the files are the same' do
          before { Githubris::Gist.any_instance.stub(:files => stub) }

          context 'the user is the same' do
            before { Githubris::Gist.any_instance.stub(:user => stub) }

            it { should be_true }

          end

          context 'the user isn\'t the same' do
            let(:this) { Githubris::Gist.new(:user => :the_right_user) }
            let(:other) { Githubris::Gist.new(:user => :not_the_right_user) }

            it { should be_false }
          end

          it { should be_true }
        end

        context 'the files are\'t the same' do
          let(:other) { Githubris::Gist.new(:files => {:stub => stub}) }

          it { should be_false }
        end
      end

      context 'the gists were created at different times' do
        let(:this) { Githubris::Gist.new(:created_at => DateTime.new(2012).to_s)}
        let(:other) { Githubris::Gist.new(:created_at => DateTime.new(1990)).to_s }

        it { should be_false }
      end
    end

    context 'the other\'s class is not Githubris::Gist' do
      let(:other) { stub }

      it { should be_false }
    end
  end
end

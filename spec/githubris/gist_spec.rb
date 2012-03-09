require 'spec_helper'

describe Githubris::Gist do

  describe '#==' do
    let(:this) { Githubris::Gist.new }
    subject { this == other }

    context 'the other\'s class is Githubris::Gist' do
      let(:other) { Githubris::Gist.new }

      context 'the gists have the same creation times' do
        before { Githubris::Gist.any_instance.stub(created_at: stub) }

        context 'the files are the same' do
          before { Githubris::Gist.any_instance.stub(files: stub) }

          context 'the user is the same' do
            before { Githubris::Gist.any_instance.stub(user: stub) }

            it { should be_true }

          end

          context 'the user isn\'t the same' do
            let(:this) { Githubris::Gist.new(user: :the_right_user) }
            let(:other) { Githubris::Gist.new(user: :not_the_right_user) }

            it { should be_false }
          end

          it { should be_true }
        end

        context 'the files are\'t the same' do
          let(:other) { Githubris::Gist.new(files: stub) }

          it { should be_false }
        end
      end

      context 'the gists were created at different times' do
        let(:this) { Githubris::Gist.new(created_at: DateTime.new(2012))}
        let(:other) { Githubris::Gist.new(created_at: DateTime.new(1990)) }

        it { should be_false }
      end
    end

    context 'the other\'s class is not Githubris::Gist' do
      let(:other) { stub }

      it { should be_false }
    end
  end

  it 'new gists are created now' do
    DateTime.stub(now: DateTime.new(2012))
    subject.created_at.should eql DateTime.now
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

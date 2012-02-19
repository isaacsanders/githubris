require 'spec_helper'

describe Githubris::Gist do
  context 'class methods' do
    subject { Githubris::Gist }
    it_behaves_like 'a collection API'
    describe ".public_gists" do
      context "when there are no gists" do
        it "is an empty collection" do
          subject.public_gists.should eql []
        end
      end
    end
  end

  context 'instance methods' do
    let(:gist) { Githubris::Gist.new }

    it_behaves_like 'a commentable API'
    its(:user) { should be_instance_of Githubris::User }

    it "new gists belong to the authenticated user" do
      Githubris.login("your_mom", "ae352")
      gist.user.should eql Githubris.authenticated_user
    end

    context "with no authenticated user" do
      before { Githubris.logout }

      it "explodifies" do
        gist.user.should eql Githubris.authenticated_user
      end
    end

    context "Gist owned by Isaac" do
      subject { Githubris::Gist.new user: user }
      let(:user) { stub("User", name: "Isaac Sanders") }
      its(:user) { should eql user }
    end


    describe "a gist without files" do
      its(:files) { should be_empty }
    end
    describe 'a gist created with a file' do
      subject do
        Githubris::Gist.new(files: [Githubris::Gist::File.new])
      end

      it "has one file" do
        subject.files.count.should eql 1
      end

      its(:files) { should all.be_instance_of Githubris::Gist::File }

      describe "saving" do
        it 'gets sent to github' do
          Githubris::API.stub(:save_gist)
          subject.save
          Githubris::API.should have_received(:save_gist).with(subject)
        end
      end
    end
  end
end

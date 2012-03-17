require 'spec_helper'

describe Githubris::Builder do
  let(:gist_collection_data) { Githubris::SpecHelper.gist_collection_data }

  describe '#build_gists' do
    it 'is an array of gists' do
      gists = subject.build_gists(gist_collection_data)
      gists.should be_instance_of Array
      gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end
  end

  describe '#build_users' do
    let(:user_data) { Githubris::SpecHelper.user_data }
    context 'schema' do
      subject { Githubris::Builder.new.build_user user_data }

      its(:login)      { should be_instance_of String }
      its(:id)         { should be_instance_of Fixnum }
      its(:avatar_url) { should be_kind_of URI }
      its(:url)        { should be_kind_of URI }
      its(:gravatar_id) { should be_instance_of String }
    end
  end
end

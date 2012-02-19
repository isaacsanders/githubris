shared_examples 'a commentable API' do
  its(:comment_uri) { should be_instance_of String }
end

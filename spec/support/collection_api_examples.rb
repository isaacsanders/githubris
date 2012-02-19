shared_examples 'a collection API' do
  its(:list_uri) { should be_instance_of String }
end

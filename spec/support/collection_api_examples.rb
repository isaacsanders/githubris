shared_examples 'a collection API' do
  its(:list_url) { should be_instance_of String }
end

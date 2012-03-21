require 'fakeweb'

def stub_get_path_with_file(path, file)
  FakeWeb.register_uri(:get, path, :body => File.open(file){|f| f.read })
end

FakeWeb.allow_net_connect = false

path_file_hash = {
  /gists\/public/                                                     => "spec/support/public_gists.json",
  /users\/([^\/]*)\/gists\z/                                          => "spec/support/user_public_gists.json",
  /users\/\w+\z/                                                      => "spec/support/user.json",
  /gists\/\d+/                                                        => 'spec/support/gist.json',
  /GithubrisTestUser:password@api\.github\.com\/user\z/     => "spec/support/user.json",
  /GithubrisTestFakeUser:password@api\.github\.com\/user\z/ => "spec/support/bad_credentials.json",
  'https://api.github.com/user'                                       => 'spec/support/requires_authentication.json',
}

path_file_hash.each do |path, file|
  stub_get_path_with_file(path, file)
end

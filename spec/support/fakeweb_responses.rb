require 'fakeweb'

def stub_get_path_with_file(path, file)
  FakeWeb.register_uri(:get, path, :body => File.open(file){|f| f.read })
end

# FakeWeb.allow_net_connect = false

path_file_hash = {
  'https://GithubrisTestUser:password@api.github.com/user?' => "spec/support/user.json",
  # /user\\?[^a]*access_token/                        => 'spec/support/user.json',
  # /GithubrisTestFakeUser:password/                => "spec/support/bad_credentials.json",
}

FakeWeb.register_uri(:get, 'https://GithubrisTestUser:password@api.github.com/user?', :body => File.open("spec/support/user.json"){|f| f.read })

path_file_hash.each do |path, file|
  stub_get_path_with_file(path, file)
end

access_token_response =<<-RESPONSE
HTTP/1.1 200 OK
Server: nginx/1.0.13
Date: Wed, 21 Mar 2012 12:54:41 GMT
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Connection: keep-alive
Status: 200 OK
ETag: "fa6a87d35864200004d1eff50d685301"
X-Frame-Options: deny
X-Runtime: 14
Content-Length: 71
Cache-Control: private, max-age=0, must-revalidate
Strict-Transport-Security: max-age=2592000

access_token=1663860ddbbb9137119ff03ef2a9d819bbce4d0e&token_type=bearer
RESPONSE

FakeWeb.register_uri(:post, /github.com\/login\/oauth\/access_token/, :response => access_token_response)
  /https:\/\/github.com\/login\/oauth\/authorize/

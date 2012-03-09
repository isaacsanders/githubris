require 'fakeweb'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get, 'https://api.github.com/', :body => '{}')
FakeWeb.register_uri(:get, /gists\/public(?:[^?]*\?page=(\d+))?/,
                     :body => File.open("spec/support/public_gists_page_#{$1 || 1}.json", 'r') {|f| f.read })
FakeWeb.register_uri(:get, /users\/([^\/]*)\/gists/,
                     :body => File.open("spec/support/user_public_gists.json"){|f| f.read })

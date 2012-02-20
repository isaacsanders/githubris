require 'fakeweb'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, /api\.github\.com/, :body => "Hello World")

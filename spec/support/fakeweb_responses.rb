require 'fakeweb'

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get, 'https://api.github.com/', :body => '{}')
FakeWeb.register_uri(:get, /gists\/public/, :body => <<BODY
[{
  "files": {
    "automobili.cpp": {
      "type": "text/plain",
      "language": "C++",
      "size": 2807,
      "filename": "automobili.cpp",
      "raw_url": "https://gist.github.com/raw/5/c6375127e57ea10f61ce96baac8a619841f13c97/automobili.cpp"
    },
    "Zadatak 2": {
      "type": "text/plain",
      "language": null,
      "size": 798,
      "filename": "Zadatak 2",
      "raw_url": "https://gist.github.com/raw/5/282d4e18020171b1716996a4ca7946e196b41b88/Zadatak 2"
    },
    "stog_pokazivac.h": {
      "type": "text/plain",
      "language": "C",
      "size": 934,
      "filename": "stog_pokazivac.h",
      "raw_url": "https://gist.github.com/raw/5/6c786991f2ff98e5c12bfd4f740ec8f88f961eba/stog_pokazivac.h"
    }
  },
  "git_push_url": "git@gist.github.com:5.git",
  "public": true,
  "html_url": "https://gist.github.com/5",
  "comments": 0,
  "updated_at": "2009-10-14T10:23:14Z",
  "user": {
    "login": "maddox",
    "avatar_url": "https://secure.gravatar.com/avatar/366472c969c9754ae2b8079e42fed1ca?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "url": "https://api.github.com/users/maddox",
    "gravatar_id": "366472c969c9754ae2b8079e42fed1ca",
    "id": 260
  },
  "url": "https://api.github.com/gists/5",
  "created_at": "2008-07-15T18:55:58Z",
  "id": "5",
  "description": null,
  "git_pull_url": "git://gist.github.com/5.git"
},
{
  "files": {
    "gistfile1.txt": {
      "type": "text/plain",
      "language": "Text",
      "size": 178,
      "filename": "gistfile1.txt",
      "raw_url": "https://gist.github.com/raw/1/9b2ac7c792209f19e157ddaf00f8946edc306a6b/gistfile1.txt"
    }
  },
  "git_push_url": "git@gist.github.com:1.git",
  "public": true,
  "html_url": "https://gist.github.com/1",
  "comments": 5,
  "updated_at": "2011-02-22T02:58:22Z",
  "user": {
    "login": "schacon",
    "avatar_url": "https://secure.gravatar.com/avatar/9375a9529679f1b42b567a640d775e7d?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "url": "https://api.github.com/users/schacon",
    "gravatar_id": "9375a9529679f1b42b567a640d775e7d",
    "id": 70
  },
  "url": "https://api.github.com/gists/1",
  "created_at": "2008-07-15T18:17:13Z",
  "id": "1",
  "description": "the meaning of gist",
  "git_pull_url": "git://gist.github.com/1.git"
}]
BODY
)

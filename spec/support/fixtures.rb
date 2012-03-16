class Githubris
  module SpecHelper
    def self.gist_collection_data
      [
        {
          "created_at" => "2008-07-20T22:54:53Z",
          "git_push_url" => "git@gist.github.com:36.git",
          "user" => {
            "avatar_url" => "https://secure.gravatar.com/avatar/fcafc7eab67d34d48b14f9d70bc05713?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
            "url" => "https://api.github.com/users/adamwiggins",
            "gravatar_id" => "fcafc7eab67d34d48b14f9d70bc05713",
            "id" => 177,
            "login" => "adamwiggins"
          },
          "public" => true,
          "url" => "https://api.github.com/gists/36",
          "description" => nil,
          "updated_at" => "2009-10-14T10:23:21Z",
          "comments" => 0,
          "files" => {
            "gistfile1.diff" => {
              "type" => "text/plain",
              "filename" => "gistfile1.diff",
              "language" => "Diff",
              "raw_url" => "https://gist.github.com/raw/36/588da740399b34cf9ab649c5198954aadc6e36ff/gistfile1.diff",
              "size" => 5467
            }
          },
          "id" => "36",
          "html_url" => "https://gist.github.com/36",
          "git_pull_url" => "git://gist.github.com/36.git"
        },
        {
          "created_at" => "2008-07-17T09:01:22Z",
          "git_push_url" => "git@gist.github.com:10.git",
          "user" => {
            "avatar_url" => "https://secure.gravatar.com/avatar/b8dbb1987e8e5318584865f880036796?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
            "url" => "https://api.github.com/users/defunkt",
            "gravatar_id" => "b8dbb1987e8e5318584865f880036796",
            "id" => 2,
            "login" => "defunkt"
          },
          "public" => true,
          "url" => "https://api.github.com/gists/10",
          "description" => "asd",
          "updated_at" => "2009-10-14T10:23:15Z",
          "comments" => 0,
          "files" => {
            "Imp_pomocu_pokazivaca" => {
              "type" => "text/plain",
              "filename" => "Imp_pomocu_pokazivaca",
              "language" => nil,
              "raw_url" => "https://gist.github.com/raw/10/ce5e83b3d8ed83c5a950f116e07505dfd2cb608a/Imp_pomocu_pokazivaca",
              "size" => 1347
            }
          },
          "id" => "10",
          "html_url" => "https://gist.github.com/10",
          "git_pull_url" => "git://gist.github.com/10.git"
        }
      ]
    end

    def self.gist_data
      {
        "created_at" => "2008-07-15T18:17:13Z",
        "git_push_url" => "git@gist.github.com:1.git",
        "user" => {
          "avatar_url" => "https://secure.gravatar.com/avatar/9375a9529679f1b42b567a640d775e7d?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
          "url" => "https://api.github.com/users/schacon",
          "gravatar_id" => "9375a9529679f1b42b567a640d775e7d",
          "id" => 70,
          "login" => "schacon"
        },
        "public" => true,
        "url" => "https://api.github.com/gists/1",
        "description" => "the meaning of gist",
        "updated_at" => "2011-02-22T02:58:22Z",
        "comments" => 5,
        "files" => {
          "gistfile1.txt" => {
            "type" => "text/plain",
            "filename" => "gistfile1.txt",
            "language" => "Text",
            "raw_url" => "https://gist.github.com/raw/1/9b2ac7c792209f19e157ddaf00f8946edc306a6b/gistfile1.txt",
            "size" => 178
          }
        },
        "id" => "1",
        "html_url" => "https://gist.github.com/1",
        "git_pull_url" => "git://gist.github.com/1.git"
      }
    end

    def self.user_data
      {
        "public_gists" => 2,
        "type" => "User",
        "following" => 0,
        "login" => "GithubrisTestUser",
        "avatar_url" => "https://secure.gravatar.com/avatar/20de3fd01e285d14de84067c34ab74d2?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "public_repos" => 1,
        "followers" => 0,
        "html_url" => "https://github.com/GithubrisTestUser",
        "url" => "https://api.github.com/users/GithubrisTestUser",
        "created_at" => "2012-02-24T12:23:28Z",
        "gravatar_id" => "20de3fd01e285d14de84067c34ab74d2",
        "id" => 1469392
      }
    end
  end
end

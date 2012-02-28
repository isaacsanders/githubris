module Fixtures
  def test_public_gists
    Githubris::Builder.new.build gist_data
  end

  def gist_data
    [
      {
        "files" => {
          "test.rb" => {
            "type" => "application/ruby",
            "language" => "Ruby",
            "size" => 35,
            "filename" => "test.rb",
            "raw_url" => "https://gist.github.com/raw/1901849/618cb237464a83cba15c5c16e913679a2703f3e0/test.rb"
          }
        },
        "public" => true,
        "git_pull_url" => "git://gist.github.com/1901849.git",
        "comments" => 0,
        "updated_at" => "2012-02-24T16:20:22Z",
        "git_push_url" => "git@gist.github.com:1901849.git",
        "user" => {
          "login" => "GithubrisTestUser",
          "url" => "https://api.github.com/users/GithubrisTestUser",
          "avatar_url" => "https://secure.gravatar.com/avatar/20de3fd01e285d14de84067c34ab74d2?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
          "gravatar_id" => "20de3fd01e285d14de84067c34ab74d2",
          "id" => 1469392
        },
        "url" => "https://api.github.com/gists/1901849",
        "created_at" => "2012-02-24T16:20:22Z",
        "id" => "1901849",
        "description" => "This is a test gist",
        "html_url" => "https://gist.github.com/1901849"
      },
      {
        "files" => {
          "slipsum.html" => {
            "type" => "text/html",
            "language" => "HTML",
            "size" => 555,
            "filename" => "slipsum.html",
            "raw_url" => "https://gist.github.com/raw/1901843/85d293b0fbc401adb58902fa24711e45e389fc3d/slipsum.html"
          },
          "example.md" => {
            "type" => "text/plain",
            "language" => "Markdown",
            "size" => 27,
            "filename" => "example.md",
            "raw_url" => "https://gist.github.com/raw/1901843/d9213baf064e7d4b9619143371172b49d97c29b8/example.md"
          }
        },
        "public" => true,
        "git_pull_url" => "git://gist.github.com/1901843.git",
        "comments" => 0,
        "updated_at" => "2012-02-24T16:19:48Z",
        "git_push_url" => "git@gist.github.com:1901843.git",
        "user" => {
          "login" => "GithubrisTestUser",
          "url" => "https://api.github.com/users/GithubrisTestUser",
          "avatar_url" => "https://secure.gravatar.com/avatar/20de3fd01e285d14de84067c34ab74d2?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
          "gravatar_id" => "20de3fd01e285d14de84067c34ab74d2",
          "id" => 1469392
        },
        "url" => "https://api.github.com/gists/1901843",
        "created_at" => "2012-02-24T16:19:48Z",
        "id" => "1901843",
        "description" => "This is a gist with many files",
        "html_url" => "https://gist.github.com/1901843"
      }
    ]
  end
end

World(Fixtures)

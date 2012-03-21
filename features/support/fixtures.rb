module Fixtures
  def test_public_gists
    build_gists get_public_gists_data
  end

  def test_user_public_gists
    build_gists get_user_public_gists_data
  end

  def test_user
    build_user get_user_data
  end

  def test_gist
    build_gist get_gist_data
  end

  def test_username
    test_credentials['username']
  end

  def test_fake_username
    "GithubrisTestFakeUser"
  end

  def test_password
    test_credentials['password']
  end

  def test_client_id
    test_credentials['client_id']
  end

  def test_client_secret
    test_credentials['client_secret']
  end

  def test_credentials
    MultiJson.decode(File.open('spec/support/credentials.json'){|f| f.read})
  end

  def build_gists data
    Githubris::Builder.new.build_gists data
  end

  def build_gist data
    Githubris::Builder.new.build_gist data
  end

  def build_user data
    Githubris::Builder.new.build_user data
  end

  def get_user_public_gists_data
    MultiJson.decode(File.open("spec/support/user_public_gists.json") {|f| f.read})
  end

  def get_public_gists_data(page=1)
    MultiJson.decode(File.open("spec/support/public_gists_page_#{page}.json") {|f| f.read })
  end

  def get_user_data
    MultiJson.decode(File.open('spec/support/user.json') {|f| f.read })
  end

  def get_gist_data
    MultiJson.decode(File.open('spec/support/gist.json') {|f| f.read })
  end
end

World(Fixtures)

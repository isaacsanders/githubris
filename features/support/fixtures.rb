module Fixtures
  def test_public_gists
    build_gists get_public_gists_data
  end

  def test_user_public_gists
    build_gists get_user_public_gists_data
  end

  def build_gists data
    Githubris::Builder.new.build_gists data
  end

  def get_user_public_gists_data
    MultiJson.decode(File.open("features/support/user_public_gists.json") {|f| f.read})
  end

  def get_public_gists_data(page=1)
    MultiJson.decode(File.open("features/support/public_gists_page_#{page}.json") {|f| f.read })
  end
end

World(Fixtures)

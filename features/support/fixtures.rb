module Fixtures
  def test_public_gists
    Githubris::Builder.new.build get_public_gists_data
  end

  def get_public_gists_data(page=1)
    MultiJson.decode(File.open("features/support/public_gists_page_#{page}.json") {|f| f.read })
  end
end

World(Fixtures)

class Githubris::Builder
  autoload :Gist, 'githubris/builder/gist'
  autoload :User, 'githubris/builder/user'
  def initialize
    @gist_builder = Githubris::Builder::Gist.new
  end

  def build_gists(data)
    data = [data].flatten
    data.map do |gist|
      @gist_builder.build gist
    end
  end

  def build_users(data)
    Githubris::Builder::User.new.build(data)
  end
end

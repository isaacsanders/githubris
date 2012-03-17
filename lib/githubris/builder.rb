class Githubris::Builder
  autoload :Gist, 'githubris/builder/gist'
  autoload :User, 'githubris/builder/user'

  def build_gists(data)
    data = [data].flatten
    data.map do |gist|
      Githubris::Builder::Gist.new.build gist
    end
  end

  def build_user(data)
    Githubris::Builder::User.new.build(data)
  end
end

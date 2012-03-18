class Githubris::Builder
  def build_gists(data)
    data = [data].flatten
    data.map do |gist|
      Githubris::Gist.new build(gist)
    end
  end

  def build_user(data)
    Githubris::User.new build(data)
  end

  def build(data)
    attributes = {}
    data.each_pair do |key, value|
      attributes[key.to_sym] = value
    end
    attributes
  end
end

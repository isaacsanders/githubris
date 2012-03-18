class Githubris::Builder
  def build_gists(data)
    if data.is_a? Array
      data = [data].flatten
      data.map do |gist|
        build_gist gist
      end
    else
      build_gist data
    end
  end

  def build_gist(data)
    Githubris::Gist.new build(data)
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

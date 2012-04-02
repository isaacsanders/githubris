class Githubris::Builder
  def build_gists(data)
    if data.is_a? Array
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

  def build_error(data)
    words = data['message'].split(' ')
    words.map! do |word|
      word.capitalize
    end
    error_class_name = words.join
    Githubris::Error.const_get(error_class_name)
  end

  def build(data)
    attributes = {}
    data.each_pair do |key, value|
      attributes[key.to_sym] = value
    end
    attributes
  end
end

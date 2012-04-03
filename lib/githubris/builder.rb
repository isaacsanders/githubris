class Githubris::Builder
  def build_gists(data)
    data.map {|gist| build_gist gist}
  end

  def build_gist(data)
    Githubris::Gist.new build(data)
  end

  def build_user(data)
    Githubris::User.new build(data)
  end

  def build_error(data)
    words = data['message'].split(' ')
    error_class_name = words.map {|word| word.capitalize}.join
    Githubris::Error.const_get(error_class_name)
  end

  private
  def build(data)
    attributes = {}
    data.each_pair do |key, value|
      attributes[key.to_sym] = value
    end
    attributes
  end
end

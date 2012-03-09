class Githubris::Gist
  autoload :File, 'githubris/gist/file'

  def self.default_options
    {
      files: [],
      created_at: DateTime.now,
      updated_at: DateTime.now
    }
  end

  def initialize options={}
    options.merge! Githubris::Gist.default_options do |given_key, given_value|
      if Githubris::Gist.default_options.has_key? given_key
        given_value
      end
    end

    @options = options
  end

  def user
    @options[:user]
  end

  def created_at
    @options[:created_at]
  end

  def updated_at
    @options[:updated_at]
  end

  def description
    @options[:description]
  end

  def files
    @options[:files]
  end

  def url
    @options[:url]
  end

  def public?
    @options[:public]
  end

  def comments
    @options[:comments]
  end

  def ==(other)
    self.class == other.class &&
      self.created_at == other.created_at &&
      self.files == other.files &&
      self.user == other.user
  end
end

class Githubris::Gist
  autoload :File, 'githubris/gist/file'

  def self.default_attributes
    {
      files: [],
      created_at: DateTime.now,
      updated_at: DateTime.now
    }
  end

  def initialize attributes={}
    attributes.merge! Githubris::Gist.default_attributes do |given_key, given_value|
      if Githubris::Gist.default_attributes.has_key? given_key
        given_value
      end
    end

    @attributes = attributes
  end

  def id
    @attributes[:id]
  end

  def user
    @attributes[:user]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def description
    @attributes[:description]
  end

  def files
    @attributes[:files]
  end

  def url
    @attributes[:url]
  end

  def public?
    @attributes[:public]
  end

  def comments
    @attributes[:comments]
  end

  def ==(other)
    self.class == other.class &&
      self.created_at == other.created_at &&
      self.files == other.files &&
      self.user == other.user
  end
end

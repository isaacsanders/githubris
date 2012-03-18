require 'date'

class Githubris::Gist
  autoload :File, 'githubris/gist/file'

  def self.default_attributes
    {
      :files => {},
      :created_at => DateTime.now.to_s,
      :updated_at => DateTime.now.to_s,
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
    Integer(@attributes[:id])
  end

  def user
    unless @attributes[:user].instance_of? Githubris::User
      @attributes[:user] = Githubris::Builder.new.build_user @attributes[:user]
    else
      @attributes[:user]
    end
  end

  def created_at
    DateTime.parse @attributes[:created_at]
  end

  def updated_at
    DateTime.parse @attributes[:updated_at]
  end

  def description
    @attributes[:description]
  end

  def files
    @attributes[:files].values
  end

  def url
    URI.parse @attributes[:url]
  end

  def public?
    @attributes[:public]
  end

  def comments
    Array.new @attributes[:comments], Githubris::Comment.new
  end

  def ==(other)
    @attributes == other.instance_variable_get(:@attributes)
  end

  def reload
    other = Githubris::API.new.get_gist id
    instance_variable_set(:@attributes, other.instance_variable_get(:@attributes))
    self
  end
end

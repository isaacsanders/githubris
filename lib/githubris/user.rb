class Githubris::User
  def initialize(attributes={})
    @api = attributes.delete(:_api) || Githubris::API.new
    @attributes = attributes
  end

  def login
    @attributes[:login]
  end

  def id
    Integer(@attributes[:id])
  end

  def avatar_url
    URI.parse @attributes[:avatar_url]
  end

  def url
    URI.parse @attributes[:url]
  end

  def gravatar_id
    @attributes[:gravatar_id]
  end

  def gists(options={})
    @api.get_user_gists(@attributes[:login])
  end

  def starred_gists(options={})
    @api.get_user_starred_gists(options)
  end

  def == other
    @attributes == other.instance_variable_get(:@attributes)
  end

  def reload
    swap_attributes @api.get_user @attributes[:login]
  rescue Githubris::Error => error
    case error
    when Githubris::Error::NotFound
      raise error, "user with login '#{@attributes[:login]}' does not exist"
    else
      raise error
    end
  end

  def swap_attributes(other)
    instance_variable_set(:@attributes,
                          other.instance_variable_get(:@attributes))
    self
  end
end

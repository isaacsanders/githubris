class Githubris::User
  def initialize attributes={}
    @attributes = attributes
  end

  def public_gists
    Githubris::API.new.get_user_public_gists(@attributes[:login])
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

  def == other
    other_attrs = other.instance_variable_get(:@attributes)
    if other_attrs
      @attributes == other_attrs
    end
  end
end

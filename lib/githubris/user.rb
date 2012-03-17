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
    @attributes[:id]
  end

  def avatar_url
    @attributes[:avatar_url]
  end

  def url
    @attributes[:url]
  end

  def gravatar_id
    @attributes[:gravatar_id]
  end
end

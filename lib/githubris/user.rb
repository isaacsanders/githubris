class Githubris::User
  def initialize attributes={}
    @attributes = attributes
  end

  def public_gists
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
end

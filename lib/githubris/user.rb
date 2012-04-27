class Githubris::User < Githubris::Base
  uri_attribute :avatar_url, :url
  readable_attribute :login, :id, :gravatar_id

  def gists(options={})
    @api.get_user_gists(login)
  end

  def starred_gists(options={})
    @api.get_starred_gists(options)
  end

  def reload
    swap_attributes! @api.get_user(login)
  end
end

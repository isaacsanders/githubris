class Githubris::User < Githubris::Base
  uri_attribute :avatar_url, :url, :blog
  readable_attribute :login, :id, :gravatar_id
  accessible_attribute :name, :email, :company, :location, :bio
  writable_attribute :blog
  boolean_attribute :hireable

  def emails
    @api.get_emails
  end

  def followers
    @api.get_user_followers(login)
  end

  def following
    @api.get_user_following(login)
  end

  def following?(other_login)
    @api.get_user_following?(other_login)
  end

  def follow!(other_login)
    @api.put_follow_user(other_login)
  end

  def unfollow!(other_login)
    @api.delete_follow_user(other_login)
  end

  def gists(options={})
    @api.get_user_gists(login)
  end

  def starred_gists(options={})
    @api.get_starred_gists(options)
  end

  def reload
    swap_attributes! @api.get_user(login)
  end

  def save
    swap_attributes! @api.patch_user(saving_attributes)
  end

  def saving_attributes
    {
      :name => name,
      :email => email,
      :blog => blog.to_s,
      :company => company,
      :location => location,
      :hireable => hireable?,
      :bio => bio
    }
  end
end

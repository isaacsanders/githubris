module Githubris::API::Gist

  def get_user_public_gists(login)
    get user_gists_path(login)
  end

  def get_public_gists(options={})
    login = options.delete(:user)
    return get_user_public_gists(login) if login

    get public_gists_path, options
  end

  def get_gist(id)
    get gist_path(id)
  end

  def get(path, options={})
    @builder.build_gists attributes_from(path, options)
  end

  def gist_data_from(path, options={})
    self.class.get(path, :query => options)
  end

  def public_gists_path
    '/gists/public'
  end

  def user_gists_path(login)
    "/users/#{login}/gists"
  end

  def gist_path(id)
    "/gists/#{id}"
  end
end

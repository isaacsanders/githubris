module Githubris::API::Gist

  def get_user_gists(login, options={})
    build_gists_from(user_gists_path(login), options)
  end

  def get_public_gists(options={})
    build_gists_from(public_gists_path, options)
  end

  def get_gist(id)
    build_gist_from(gist_path(id))
  end

  private
  def build_gists_from(path, options={})
    @builder.build_gists get_data_from(path, options)
  end

  def build_gist_from(path, options={})
    @builder.build_gist get_data_from(path)
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

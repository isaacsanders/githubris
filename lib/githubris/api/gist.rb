module Githubris::API::Gist

  def get_user_gists(login)
    build_gists_from user_gists_path(login)
  end

  def get_public_gists(options={})
    build_gists_from public_gists_path, options
  end

  def get_gist(id)
    build_gists_from gist_path(id)
  end

  def build_gists_from(path, options={})
    @builder.build_gists get_data_from(path, options)
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

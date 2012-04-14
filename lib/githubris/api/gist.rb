module Githubris::API::Gist

  def get_user_gists(login, options={})
    get_gists_from(user_gists_path(login), options)
  end

  def get_user_starred_gists(options={})
    get_gists_from(user_starred_gists_path, options)
  end

  def get_public_gists(options={})
    get_gists_from(public_gists_path, options)
  end

  def get_gist(id)
    get_gist_from(gist_path(id))
  end

  def post_gist(params)
    post_gist_to(gists_path, params)
  end

  def patch_gist(id, params)
    patch_gist_to(gist_path(id), params)
  end

  private
  def get_gists_from(path, options={})
    get_data_from(path, options).map do |gist_data|
      Githubris::Gist.new gist_data
    end
  end

  def get_gist_from(path)
    Githubris::Gist.new get_data_from(path)
  end

  def post_gist_to(path, params)
    Githubris::Gist.new post_data_to(path, params)
  end

  def patch_gist_to(path, params)
    Githubris::Gist.new patch_data_to(path, params)
  end

  def public_gists_path
    "#{gists_path}/public"
  end

  def user_gists_path(login)
    "/users/#{login}/gists"
  end

  def user_starred_gists_path
    "#{gists_path}/starred"
  end

  def gist_path(id)
    "#{gists_path}/#{id}"
  end

  def gists_path
    '/gists'
  end
end

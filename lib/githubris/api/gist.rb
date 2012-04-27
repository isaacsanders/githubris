module Githubris::API::Gist

  def get_user_gists(login, options={})
    get_gists_from(user_gists_path(login), options)
  end

  def get_starred_gists(options={})
    get_gists_from(starred_gists_path, options)
  end

  def get_public_gists(options={})
    get_gists_from(public_gists_path, options)
  end

  def get_gist(id)
    get_gist_from(gist_path(id))
  end

  def put_gist_star(id)
    set_request_path(gist_star_path(id))
    raw_put(@target, @options.merge(:headers => {'Content-Length' => '0'}))
  end

  def delete_gist_star(id)
    set_request_path(gist_star_path(id))
    raw_delete
  end

  def delete_gist(id)
    set_request_path(gist_path(id))
    raw_delete
  end

  def get_gist_starred?(id)
    set_request_path(gist_star_path(id))
    case raw_get.code
    when 204
      true
    when 404
      false
    end
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
    '/gists/public'
  end

  def user_gists_path(login)
    "/users/#{login}/gists"
  end

  def starred_gists_path
    '/gists/starred'
  end

  def gist_star_path(id)
    "/gists/#{id}/star"
  end

  def gist_path(id)
    "/gists/#{id}"
  end

  def gists_path
    '/gists'
  end
end

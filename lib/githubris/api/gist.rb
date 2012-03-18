module Githubris::API::Gist
  PUBLIC_GISTS_PATH = '/gists/public'

  def get_user_public_gists(login)
    get user_gists_path(login)
  end

  def get_public_gists(options={})
    login = options.delete(:user)
    return get_user_public_gists(login) if login

    get public_gists_path_for_page(options[:page])
  end

  def get_gist(id)
    get gist_path(id)
  end

  def get(path)
    @builder.build_gists attributes_from(path)
  end

  def attributes_from(path)
    self.class.get(path)
  end

  def public_gists_path_for_page page_number=1
    "#{PUBLIC_GISTS_PATH}?page=#{page_number}"
  end

  def user_gists_path(login)
    "/users/#{login}/gists"
  end

  def gist_path(id)
    "/gists/#{id}"
  end
end

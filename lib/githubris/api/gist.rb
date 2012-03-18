module Githubris::API::Gist
  PUBLIC_GISTS_PATH = '/gists/public'

  def get_user_public_gists(login)
    data = self.class.get user_gists_path(login)
    gists = @builder.build_gists(data)
    gists.map do |gist|
      gist.set_attribute(:user, get_user(login))
      gist
    end
  end

  def get_public_gists(options={})
    login = options.delete(:user)
    return get_user_public_gists(login) if login

    data = self.class.get public_gists_path_for_page(options[:page])
    @builder.build_gists data
  end

  private
  def public_gists_path_for_page page_number=1
    "#{PUBLIC_GISTS_PATH}?page=#{page_number}"
  end

  def user_gists_path(login)
    "/users/#{login}/gists"
  end
end

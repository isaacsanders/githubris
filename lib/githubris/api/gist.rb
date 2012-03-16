require 'githubris/builder/gist'

module Githubris::API::Gist
  PUBLIC_GISTS_PATH = '/gists/public'

  def get_public_gists(options={})
    if options[:user]
      data = self.class.get "/users/#{options[:user]}/gists"
      return build(data)
    end

    data = self.class.get public_gists_path_for_page(options[:page])
    build data
  end

  private
  def public_gists_path_for_page page_number=1
    "#{PUBLIC_GISTS_PATH}?page=#{page_number}"
  end

  def build(data)
    @builder.build_gists(data)
  end
end

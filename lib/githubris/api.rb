require 'httparty'

class Githubris::API
  include HTTParty
  base_uri 'https://api.github.com'
  format :json

  GISTS_PER_PAGE = 30
  PUBLIC_GISTS_PATH = '/gists/public'

  def initialize
    @builder = Githubris::Builder.new
  end

  def authenticate!(options={})
    Githubris::API.basic_auth options[:login], options[:password]
  end

  def get_public_gists(options={})

    if options[:user]
      data = Githubris::API.get "/users/#{options[:user]}/gists"
      return @builder.build(data)
    end

    data = Githubris::API.get public_gists_path_for_page(options[:page])
    @builder.build(data)
  end

  def get_user(options={})
    Githubris::User.new
  end

  private
  def public_gists_path_for_page page_number=1
    "#{PUBLIC_GISTS_PATH}?page=#{page_number}"
  end
end

require 'httparty'

class Githubris::API
  include HTTParty

  require_relative 'api/gist'
  include Githubris::API::Gist
  require_relative 'api/user'
  include Githubris::API::User

  base_uri 'https://api.github.com'
  format :json

  def initialize
    @builder = Githubris::Builder.new
    empty_default_params
  end

  def empty_default_params
    self.class.default_params {}
  end

  def basic_auth login, password
    self.class.basic_auth login, password
  end

  def oauth(client_id, client_secret)
    oauth = Githubris::OAuth.new client_id, client_secret
  end

  def authenticated?
    true if get_authenticated_user
  rescue Githubris::Error => e
    false
  end

  def get_data_from(path, options={})
    data = self.class.get(path, :query => options)
    if data.is_a? Hash and data['message']
      raise @builder.build_error data
    else
      data
    end
  end

  def post_oauth_access_token(params)
    set_default_params self.class.post(oauth_access_token_url,
                                      :query => params,
                                      :parser => access_token_parser)
  end

  def set_default_params(params)
    self.class.default_params params
  end

  def oauth_access_token_url
    "https://github.com/login/oauth/access_token"
  end

  def access_token_parser
    lambda do |uri, format|
      pairs = uri.split('&')
      pairs.inject({}) do |params, pair|
        pair = pair.split('=')
        key = pair[0].to_sym
        value = pair[1]
        params[key] = value
        params
      end
    end
  end
end

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
    unless data.is_a? Array
      if data['message']
        raise @builder.build_error data
      else
        data
      end
    else
      data
    end
  end

  def post_oauth_access_token(params)
    self.class.default_params self.class.post("https://github.com/login/oauth/access_token",:query => params, :parser => access_token_parser)
  end

  def access_token_parser
    lambda do |uri, format|
      pairs = uri.split('&')
      pairs.inject({ }) do |params, pair|
        pair = pair.split('=')
        key = pair[0].to_sym
        value = pair[1]
        params[key] = value
        params
      end
    end
  end
end

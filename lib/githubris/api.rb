require 'httparty'
require 'addressable/uri'

class Githubris::API
  include HTTParty

  require_relative 'api/gist'
  include Githubris::API::Gist
  require_relative 'api/user'
  include Githubris::API::User

  def initialize
    @builder = Githubris::Builder.new
    @target = Addressable::URI.new default_uri_options
  end

  def default_uri_options
    {
      :scheme => 'https',
      :host => 'api.github.com',
    }
  end

  def basic_auth login, password
    @target.user = login
    @target.password = password
  end

  def oauth(client_id, client_secret)
    oauth = Githubris::OAuth.new client_id, client_secret
  end

  def authenticated?
    get_authenticated_user
  rescue Githubris::Error::RequiresAuthentication
    nil
  end

  def get_data_from(path, options={})
    data = get(path, options)
    data = MultiJson.decode data if data.is_a? String
    raise @builder.build_error data if error_data?(data)
    data
  end

  def get(path, options={})
    @target.path = path
    @target.query_values = options
    self.class.get(@target.to_s)
  end

  def error_data?(data)
    data.is_a?(Hash) and data['message']
  end

  def post_oauth_access_token(params)
    @target.query ||= ''
    @target.query += post(oauth_access_token_url, :query => params)
    @target.query_values['access_token']
  end

  def post(path, options={})
    @target.path = path
    self.class.post(@target.to_s, options)
  end

  def oauth_access_token_url
    'https://github.com/login/oauth/access_token'
  end
end

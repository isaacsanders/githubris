require 'addressable/uri'

class Githubris::API

  autoload :HTTP, 'githubris/api/http'
  include Githubris::API::HTTP
  autoload :Gist, 'githubris/api/gist'
  include Githubris::API::Gist
  autoload :User, 'githubris/api/user'
  include Githubris::API::User

  def initialize
    @target = Addressable::URI.new default_uri_options
    @options = {}
  end

  def default_uri_options
    {
      :scheme => 'https',
      :host => 'api.github.com',
    }
  end

  def basic_auth login, password
    @options[:basic_auth] = {
      :username => login,
      :password => password
    }
  end

  def oauth(client_id, client_secret)
    oauth = Githubris::OAuth.new client_id, client_secret
  end

  def authenticated?
    get_authenticated_user
  rescue Githubris::Error::RequiresAuthentication, Githubris::Error::BadCredentials
    nil
  end

  def get_data_from(path, options={})
    this = self
    data = get(path, options)
    data = MultiJson.decode(data, :symbolize_keys => true)
    raise build_error data if error_data?(data)

    embed_self_in data
  end

  def build_error data
    words = data[:message].split(' ')
    error_class_name = words.map {|word| word.capitalize}.join
    Githubris::Error.const_get(error_class_name)
  end

  def get(path, options={})
    @target.path = path
    @target.query_values = options
    MultiJson.encode(_get(@target.to_s))
  end

  def error_data?(data)
    data.is_a?(Hash) and data[:message]
  end

  def post_oauth_access_token(params)
    @target.query ||= ''
    @target.query += _post(oauth_access_token_url, :query => params)
    @target.query_values['access_token']
  end

  def post_data_to(path, params)
    data = post(path, MultiJson.encode(params))
    data = MultiJson.decode(data, :symbolize_keys => true) if data.is_a? String
    raise build_error data if error_data?(data)

    embed_self_in data
  end

  def embed_self_in(data)
    this = self
    if data.is_a? Array
      data.each {|data_el| data_el[:_api] = this }
    else
      data[:_api] = this
    end

    data
  end

  def post(path, params)
    @target.path = path
    @options[:body] = params
    MultiJson.encode(_post(@target.to_s))
  end

  def oauth_access_token_url
    'https://github.com/login/oauth/access_token'
  end
end

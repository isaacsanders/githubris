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
      :query => ''
    }
  end

  def basic_auth login, password
    @options[:basic_auth] = {
      :username => login,
      :password => password
    }
  end

  def oauth(client_id, client_secret)
    Githubris::OAuth.new client_id, client_secret, self
  end

  def authenticated?
    get_authenticated_user
  rescue Githubris::Error::RequiresAuthentication, Githubris::Error::BadCredentials
    nil
  end

  def get_data_from(path, options={})
    handle_request_data get(path, options)
  end

  def get(path, options={})
    set_request_path(path)
    @target.query_values = options
    encode_json(_get.parsed_response)
  end

  def post_oauth_access_token(params)
    @target.query += _post(oauth_access_token_url, :query => params)
    @target.query_values['access_token']
  end

  def post_data_to(path, params)
    handle_request_data post(path, encode_json(params))
  end

  def post(path, params)
    set_request(path, params)
    encode_json(_post.parsed_response)
  end

  def patch_data_to(path, params)
    handle_request_data patch(path, encode_json(params))
  end

  def patch(path, params)
    set_request(path, params)
    encode_json(_patch.parsed_response)
  end

  def put_data_to(path, params)
    handle_request_data put(path, encode_json(params))
  end

  def put(path, params)
    set_request(path, params)
    encode_json(_put.parsed_response)
  end

  private

  def set_request(path, params)
    set_request_path(path)
    set_request_params(params)
  end

  def set_request_params(params)
    @options[:body] = params
  end

  def set_request_path(path)
    @target.path = path
  end

  def handle_request_data(data)
    data = decode_json(data) if data.is_a? String
    raise build_error data if error_data?(data)
    embed_self_in data
  end

  def build_error data
    words = data[:message].split(' ')
    error_class_name = words.map {|word| word.capitalize}.join
    Githubris::Error.const_get(error_class_name)
  end

  def error_data?(data)
    data.is_a?(Hash) and data[:message]
  end

  def decode_json(json)
    MultiJson.decode(json, :symbolize_keys => true)
  end

  def encode_json(json)
    MultiJson.encode(json)
  end

  def embed_self_in(data)
    if data.is_a? Array
      data.map {|data_el| embed_self_in(data_el) }
    else
      data[:_api] = self
      data
    end
  end

  def oauth_access_token_url
    'https://github.com/login/oauth/access_token'
  end
end

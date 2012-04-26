require 'addressable/uri'

class Githubris::API
  require 'githubris/api/gist'
  include Githubris::API::Gist
  require 'githubris/api/http'
  include Githubris::API::HTTP
  require 'githubris/api/json'
  include Githubris::API::JSON
  require 'githubris/api/oauth'
  include Githubris::API::OAuth
  require 'githubris/api/user'
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
    dump_json(_get.parsed_response)
  end

  def post_data_to(path, params)
    handle_request_data post(path, dump_json(params))
  end

  def post(path, params)
    set_request(path, params)
    dump_json(_post.parsed_response)
  end

  def patch_data_to(path, params)
    handle_request_data patch(path, dump_json(params))
  end

  def patch(path, params)
    set_request(path, params)
    dump_json(_patch.parsed_response)
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
    data = load_json(data) if data.is_a? String
    raise error_from data if error_data?(data)
    embed_self_in data
  end

  def error_from data
    Githubris::Error.const_get(class_name_from_string(data[:message]))
  end

  def class_name_from_string(string)
    string.split(' ').map(&:capitalize).join
  end

  def error_data?(data)
    data.is_a?(Hash) and data.has_key?(:message)
  end

  def embed_self_in(data)
    if data.is_a? Array
      data.map {|data_el| embed_self_in(data_el) }
    else
      data[:_api] = self
      data
    end
  end
end

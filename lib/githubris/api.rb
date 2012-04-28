require 'addressable/uri'
require 'githubris/error'

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

  def get_data_from(path, options={})
    handle_request_data get(path, options)
  end

  def get(path, query_values={})
    set_request_path(path)
    set_request_query_values(query_values)
    dump_json(raw_get.parsed_response)
  end

  def post_data_to(path, params)
    handle_request_data post(path, dump_json(params))
  end

  def post(path, params)
    set_request(path, params)
    dump_json(raw_post.parsed_response)
  end

  def patch_data_to(path, params)
    handle_request_data patch(path, dump_json(params))
  end

  def patch(path, params)
    set_request(path, params)
    dump_json(raw_patch.parsed_response)
  end

  private

  def handle_request_data(data)
    data = load_json(data)
    raise_if_error(data)
    embed_self_in(data)
  end

  def raise_if_error(data)
    raise error_from data if error_data?(data)
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
    end
    data
  end
end

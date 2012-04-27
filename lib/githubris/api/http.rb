require 'httparty'

module Githubris::API::HTTP

  def initialize
    @target = Addressable::URI.new default_uri_options
    @options = Hash.new
  end

  def basic_auth login, password
    @options[:basic_auth] = basic_auth_credentials(login, password)
  end

  private

  def default_uri_options
    {
      :scheme => 'https',
      :host => 'api.github.com',
      :query => ''
    }
  end

  def basic_auth_credentials(login, password)
    {
      :username => login,
      :password => password
    }
  end

  def set_request_query_values(query_values)
    @target.query_values = query_values
  end

  def set_request(path, params)
    set_request_path(path)
    set_request_body(params)
  end

  def set_request_body(params)
    @options[:body] = params
  end

  def set_request_path(path)
    @target.path = path
  end

  def raw_get(path=@target, options=@options)
    HTTParty.get(path.to_s, options)
  end

  def raw_post(path=@target, options=@options)
    HTTParty.post(path.to_s, options)
  end

  def raw_put(path=@target, options=@options)
    HTTParty.put(path.to_s, options)
  end

  def raw_patch(path=@target, options=@options)
    HTTParty.patch(path.to_s, options)
  end

  def raw_delete(path=@target, options=@options)
    HTTParty.delete(path.to_s, options)
  end
end

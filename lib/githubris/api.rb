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
  end

  def basic_auth login, password
    self.class.basic_auth login, password
  end

  def oauth(client_id, client_secret, options={})
    @oauth = Githubris::OAuth.new client_id, client_secret, options
  end

  def authenticated?
    true if get_authenticated_user
  rescue Githubris::Error => e
    false
  end

  def get_data_from(path, options=nil)
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
end

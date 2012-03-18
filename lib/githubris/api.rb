require 'httparty'

class Githubris::API
  include HTTParty
  base_uri 'https://api.github.com'
  format :json

  require_relative 'api/gist'
  include Githubris::API::Gist

  require_relative 'api/user'
  include Githubris::API::User

  def initialize
    @builder = Githubris::Builder.new
  end

  def authenticate!(options={})
    Githubris::API.basic_auth options[:login], options[:password]
  end
end

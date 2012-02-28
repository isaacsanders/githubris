require 'httparty'

class Githubris::API
  include HTTParty
  base_uri 'https://api.github.com'
  format :json

  def initialize
    @builder = Githubris::Builder.new
  end

  def authenticate!(options={})
    Githubris::API.basic_auth options[:login], options[:password]
  end

  def get_public_gists
    data = Githubris::API.get('/gists/public')
    @builder.build(data)
  end

  def get_user(options={})
    Githubris::User.new
  end
end

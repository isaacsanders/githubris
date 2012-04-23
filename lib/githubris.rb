class Githubris
  autoload :API, 'githubris/api'
  autoload :Base, 'githubris/base'
  autoload :CustomAttributes, 'githubris/custom_attributes'
  autoload :Error, 'githubris/error'
  autoload :Gist, 'githubris/gist'
  autoload :OAuth, 'githubris/oauth'
  autoload :Publicity, 'githubris/publicity'
  autoload :User, 'githubris/user'
  autoload :Version, 'githubris/version'

  def initialize
    @api = Githubris::API.new
  end

  def basic_auth(login, password)
    @api.basic_auth login, password
  end

  def oauth(client_id, client_secret)
    @api.oauth client_id, client_secret
  end

  def authenticated_user
    @api.get_authenticated_user
  end

  def authenticated?
    @api.authenticated?
  end

  def find_user(login)
    @api.get_user(login)
  end

  def find_gist(id)
    @api.get_gist(id)
  end

  def public_gists(options={})
    @api.get_public_gists options
  end
end

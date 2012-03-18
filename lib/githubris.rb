$:.push File.expand_path("../../config", __FILE__)

class Githubris
  autoload :API, 'githubris/api'
  autoload :Blob, 'githubris/blob'
  autoload :Builder, 'githubris/builder'
  autoload :Comment, 'githubris/comment'
  autoload :Commit, 'githubris/commit'
  autoload :Event, 'githubris/event'
  autoload :Gist, 'githubris/gist'
  autoload :Issue, 'githubris/issue'
  autoload :Organization, 'githubris/organization'
  autoload :PullRequest, 'githubris/pull_request'
  autoload :Reference, 'githubris/reference'
  autoload :Repository, 'githubris/repository'
  autoload :Tag, 'githubris/tag'
  autoload :Tree, 'githubris/tree'
  autoload :User, 'githubris/user'
  autoload :Version, 'githubris/version'

  attr_reader :authenticated_user

  def initialize
    @api = Githubris::API.new
  end

  def authenticate(login, password)
    @api.authenticate! :login => login, :password => password
    @authenticated_user = Githubris::User.new
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

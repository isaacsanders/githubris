$:.push File.expand_path("../../config", __FILE__)
require_relative "githubris/version"

class Githubris
  autoload :API, 'githubris/api'
  autoload :Blob, 'githubris/blob'
  autoload :Builder, 'githubris/builder'
  autoload :Comment, 'githubris/comment'
  autoload :Commit, 'githubris/commit'
  autoload :Config, 'githubris/config'
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

  attr_reader :authenticated_user

  def authenticate(username, password)
    Githubris::API.basic_auth username, password
    @authenticated_user = Githubris::User.new
  end

  def find_user(login)
    Githubris::API.get_user(login: login)
  end

  def public_gists options={}
  end

  def gists options={}
  end
end

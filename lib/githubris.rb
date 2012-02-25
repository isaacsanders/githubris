$:.push File.expand_path("../../config", __FILE__)
require_relative "githubris/version"

class Githubris
  @@authenticated_user = nil

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

  def self.login(username, password)
    Githubris::API.basic_auth username, password
    @@authenticated_user = Githubris::User.new
  end

  def self.logout
    @@authenticated_user = nil
  end

  def self.authenticated_user
    @@authenticated_user
  end

  def public_gists options={}

  end

  def gists options={}
  end
end

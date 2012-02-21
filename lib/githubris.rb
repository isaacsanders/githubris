$:.push File.expand_path("../../config", __FILE__)
require_relative "githubris/version"

module Githubris
  autoload :API, 'githubris/api'
  autoload :Blob, 'githubris/blob'
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

  class << self
    def login(user_name, api_key)
      @@user = Githubris::User.new
    end

    def logout
      @@user = nil
    end

    def authenticated_user
      @@user
    end
  end
end

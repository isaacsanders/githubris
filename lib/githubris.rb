require "githubris/version"

module Githubris
  autoload 'Blob', 'githubris/blob'
  autoload 'Comment', 'githubris/comment'
  autoload 'Commit', 'githubris/commit'
  autoload 'Event', 'githubris/event'
  autoload 'Gist', 'githubris/gist'

  autoload 'Issue'            , 'githubris/issue'
  autoload 'Issue::Label'     , 'githubris/issue/label'
  autoload 'Issue::Milestone' , 'githubris/issue/milestone'

  autoload 'Organization'       , 'githubris/organization'
  autoload 'Organization::Team' , 'githubris/organization/team'

  autoload 'PullRequest', 'githubris/pull_request'
  autoload 'Reference', 'githubris/reference'

  autoload 'Repository'           , 'githubris/repository'
  autoload 'Repository::Download' , 'githubris/repository/download'
  autoload 'Repository::Fork'     , 'githubris/repository/fork'
  autoload 'Repository::Hook'     , 'githubris/repository/hook'

  autoload 'Tag', 'githubris/tag'
  autoload 'Tree', 'githubris/tree'
  autoload 'User', 'githubris/user'
end

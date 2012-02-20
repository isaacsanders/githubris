module Githubris
  class Gist
    autoload :File, 'githubris/gist/file'

    class << self
      def list_uri
        ""
      end

      def public_gists
        []
      end

      def default_options
        {
          user: Githubris.authenticated_user,
          files: [],
        }
      end
    end

    attr_reader :user, :files

    def initialize options=Githubris::Gist.default_options
      @user = options[:user]
      @files = options[:files]
    end

    def comment_uri
      ""
    end

    def save
      Githubris::API.save_gist(self)
    end
  end
end

module Githubris
  class Gist
    autoload :File, 'githubris/gist/file'

    class << self
      def list_uri
        ""
      end

      def public_gists
        Githubris::API.call(:gists, :list_public)
      end

      def default_options
        {
          'user'       => Githubris.authenticated_user,
          'files'      => [],
          'created_at' => DateTime.now.to_s,
          'updated_at' => DateTime.now.to_s
        }
      end
    end

    def initialize options={}
      options.merge! Githubris::Gist.default_options do |given_key, given_value|
        if Githubris::Gist.default_options.has_key? given_key
          given_value
        end
      end

      @options = options
    end

    def user
      @options['user']
    end

    def created_at
      DateTime.parse @options['created_at']
    end

    def updated_at
      DateTime.parse @options['updated_at']
    end

    def description
      @options['description']
    end

    def files
      @options['files']
    end

    def save
      Githubris::API.save_gist(self)
    end

    def public?
      true
    end

    def comments
      Array.new 5
    end
  end
end

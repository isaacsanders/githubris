module Githubris
  class Gist
    autoload :File, 'githubris/gist/file'

    class << self
      def list_uri
        ""
      end

      def public_gists
        self.build(Githubris::API.call(:gists, :list_public))
      end

      def default_options
        {
          'user'       => Githubris.authenticated_user,
          'files'      => [],
          'created_at' => DateTime.now.to_s,
          'updated_at' => DateTime.now.to_s
        }
      end

      def build data
        return data if data.instance_of? Githubris::Gist
        if data.instance_of? Array
          data.map do |gist_data|
            self.build gist_data
          end
        else
          Githubris::Gist.new data
        end
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
      Githubris::User.build @options['user']
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
      Githubris::Gist::File.build @options['files']
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

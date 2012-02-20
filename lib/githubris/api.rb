module Githubris
  class API
    def self.call(*args)
      options = args.inject(Githubris::Config) {|config, key| config[key]}
      Githubris::API.new(options).resolve
    end

    def initialize options
    end

    def resolve
      Net::HTTP.get('api.github.com', '/')
      {}
    end
  end
end

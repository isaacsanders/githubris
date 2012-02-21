require 'httparty'

module Githubris
  class API
    include HTTParty
    base_uri(Githubris::Config[:base_uri])

    def self.call(*args)
      options = args.inject(Githubris::Config) {|config, key| config[key]}
      Githubris::API.resolve options
    end

    def self.resolve options
      Githubris::API.get('/')
    end
  end
end

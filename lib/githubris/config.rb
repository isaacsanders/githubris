require 'yaml'

module Githubris
  module Config
    @@config = {}
    @@config.merge! YAML.load_file('config/base.yml')
    @@config.merge! YAML.load_file('config/gists.yml')

    def self.[] (key)
      @@config[key.to_s]
    end
  end
end

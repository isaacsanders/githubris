require 'httparty'

module Githubris
  class API
    include HTTParty
    base_uri(Githubris::Config[:base_uri])

    def self.call(data, *args)

      options = {data: data}
      unless args.empty?
        options.merge! args.inject(Githubris::Config) {|config, key|
          config[key]
        }
      end
      Githubris::API.resolve options
    end

    def self.resolve options
      method = options[:method].intern
      path = URI.parse(options[:path])
      puts "#{method} #{path}"
      Githubris::API.send(method, path)
    end
  end
end

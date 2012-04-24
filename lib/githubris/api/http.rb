require 'httparty'

module Githubris::API::HTTP
  private

  def self.define_httparty_method(*http_methods)
    http_methods.each do |http_method|
      module_eval http_method_string(http_method)
    end
  end

  def self.http_method_string(http_method)
    """
    def _#{http_method}(path=@target.to_s, options=@options)
      HTTParty.#{http_method}(path, options)
    end
    """
  end

  define_httparty_method :get, :post, :patch, :put, :delete
end

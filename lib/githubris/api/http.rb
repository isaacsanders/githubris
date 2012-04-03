require 'httparty'

module Githubris::API::HTTP
  private
  def _get(path, options={})
    HTTParty.get(path, options)
  end

  def _post(path, options={})
    HTTParty.post(path, options)
  end
end

require 'httparty'

module Githubris::API::HTTP
  private
  def _get(path, options=@options)
    HTTParty.get(path, options).to_json
  end

  def _post(path, options=@options)
    HTTParty.post(path, options).to_json
  end
end

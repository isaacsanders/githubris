require 'httparty'

module Githubris::API::HTTP
  private

  def _get(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end

  def _post(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end

  def _put(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end

  def _patch(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end

  def _delete(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end
end

require 'httparty'

module Githubris::API::HTTP
  private

  def _get(path=@target.to_s, options=@options)
    HTTParty.get(path, options)
  end

  def _post(path=@target.to_s, options=@options)
    HTTParty.post(path, options)
  end

  def _put(path=@target.to_s, options=@options)
    HTTParty.put(path, options)
  end

  def _patch(path=@target.to_s, options=@options)
    HTTParty.patch(path, options)
  end

  def _delete(path=@target.to_s, options=@options)
    HTTParty.delete(path, options)
  end
end

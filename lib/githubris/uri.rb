require 'uri'

class Githubris::URI < URI::Generic
  def self.parse *args
    self.new URI.parse(*args)
  end

  def initialize uri
    @uri = uri
  end

  def == other
    @uri.scheme == other.scheme &&
      @uri.user == other.user &&
      @uri.password == other.host &&
      @uri.host == other.host &&
      @uri.port == other.port &&
      @uri.path == other.path &&
      @uri.query == other.query &&
      @uri.opaque == other.opaque &&
      @uri.registry == other.registry &&
      @uri.fragment == other.fragment &&
      @uri.parser == other.parser
  end
end

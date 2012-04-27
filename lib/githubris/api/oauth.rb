require 'githubris/oauth'

module Githubris::API::OAuth
  OAUTH_ACCESS_TOKEN_URL = Addressable::URI.parse 'https://github.com/login/oauth/access_token'

  def oauth(client_id, client_secret)
    Githubris::OAuth.new(client_id, client_secret, self)
  end

  def post_oauth_access_token(params)
    proxy_uri = OAUTH_ACCESS_TOKEN_URL
    proxy_uri.query = raw_post(OAUTH_ACCESS_TOKEN_URL, :query => params)
    @options[:default_params] ||= {}
    @options[:default_params][:access_token] = proxy_uri.query_values['access_token']
  end
end

class Githubris::OAuth
  REQUEST_ACCESS_URL = "https://github.com/login/oauth/authorize"

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  def request_access_url(options={})
    url = Addressable::URI.parse REQUEST_ACCESS_URL
    query_values = {}
    query_values[:client_id] = @client_id

    redirect_uri = options.delete(:redirect_uri)
    query_values[:redirect_uri] = redirect_uri if redirect_uri

    scopes = options.delete :scopes
    if scopes
      scopes = scopes.join ','
      query_values[:scopes] = scopes
    end

    url.query_values = query_values
    url.query = URI.decode(url.query)
    url.to_s
  end

  def access_token(code)
    access_token_params = {
      :client_id => @client_id,
      :client_secret => @client_secret,
      :code => code
    }
    Githubris::API.new.post_oauth_access_token(access_token_params)
  end
end

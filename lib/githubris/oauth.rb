class Githubris::OAuth
  REQUEST_ACCESS_URL = Addressable::URI.parse("https://github.com/login/oauth/authorize")

  def initialize(client_id, client_secret, api=Githubris::API.new)
    @client_id = client_id
    @client_secret = client_secret
    @api = api
  end

  def request_access_url(query={})
    add_query_params_to(REQUEST_ACCESS_URL, query).to_s
  end

  def access_token(code)
    @api.post_oauth_access_token(access_token_params(code))
  end

  private

  def add_query_params_to(uri, query)
    uri.tap do |uri|
      uri.query_values = query_values(query)
      uri.query = URI.decode(uri.query)
    end
  end

  def query_values(query)
    query_values = { :client_id => @client_id }
    query_values[:scopes] = query[:scopes].join(',') if query[:scopes]
    query_values[:redirect_uri] = query[:redirect_uri] if query[:redirect_uri]
    query_values
  end

  def access_token_params(code)
    {
      :client_id => @client_id,
      :client_secret => @client_secret,
      :code => code
    }
  end
end

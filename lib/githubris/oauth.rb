class Githubris::OAuth
  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  def request_access_url(options={})
    url = Addressable::URI.parse "https://github.com/login/oauth/authorize"
    query_values = { :client_id => @client_id }
    url.query_values = query_values

    redirect_uri = options.delete(:redirect_uri)
    if redirect_uri
      url.query << "&redirect_uri=#{redirect_uri}"
    end

    scopes = options.delete :scopes
    if scopes
      scopes = scopes.join ','
      url.query << "&scopes=#{scopes}"
    end

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

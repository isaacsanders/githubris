class Githubris::OAuth
  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  def request_access_url(options={})
    query_params = ["client_id=#{@client_id}"]

    if options[:scopes]
      scopes = options[:scopes].join(',')
      query_params << "scopes=#{scopes}"
    end

    if options[:redirect_uri]
      redirect_uri = URI.encode options[:redirect_uri]
      query_params << "redirect_uri=#{redirect_uri}"
    end

    query = query_params.join('&')

    url = URI.parse "https://github.com/login/oauth/authorize"
    url.query = query
    url.to_s
  end

  def access_token(code)
    access_token_params = {
      :client_id => @client_id,
      :client_secret => @client_secret,
      :code => code
    }
    Githubris::API.new.post_oauth_access_token(access_token_params)[:access_token]
  end
end

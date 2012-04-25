module Githubris::API::OAuth
  OAUTH_ACCESS_TOKEN_URL = 'https://github.com/login/oauth/access_token'

  def post_oauth_access_token(params)
    @target.query += _post(OAUTH_ACCESS_TOKEN_URL, :query => params)
    @options[:default_params] ||= {}
    @options[:default_params][:access_token] = @target.query_values['access_token']
  end
end

class Githubris::OAuth
  def initialize(client_id, client_secret, options={})
    @client_id = client_id
    @client_secret = client_secret
    @options = options
  end
end

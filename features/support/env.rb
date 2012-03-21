
require 'githubris'

Before do
  @githubris = Githubris.new
end

After do
  Githubris::API.default_options.delete(:basic_auth)
end

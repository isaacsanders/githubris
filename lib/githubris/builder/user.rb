require 'githubris/builder'
require 'githubris/user'

class Githubris::Builder::User
  def build data
    user_attributes = {
      :login => data.delete('login'),
      :id => Integer(data.delete('id')),
      :avatar_url => URI.parse(data.delete('avatar_url')),
    }
    Githubris::User.new user_attributes
  end
end

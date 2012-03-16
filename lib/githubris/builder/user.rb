require 'githubris/builder'
require 'githubris/user'

class Githubris::Builder::User
  def self.build user_data
    Githubris::User.new user_data
  end
end

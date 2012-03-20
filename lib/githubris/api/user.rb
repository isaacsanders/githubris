module Githubris::API::User
  USERS_PATH = '/users'

  def get_user(login)
    data = self.class.get user_path(login)
    @builder.build_user data
  end

  def get_authenticated_user
    data = self.class.get authenticated_user_path
    @builder.build_user data
  end

  private
  def user_path(login)
    "#{USERS_PATH}/#{login}"
  end

  def authenticated_user_path
    '/user'
  end
end

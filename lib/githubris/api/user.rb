module Githubris::API::User

  def get_user(login)
    @builder.build_user get_data_from(user_path(login))
  end

  def get_authenticated_user
    @builder.build_user get_data_from(authenticated_user_path)
  end

  private
  def user_path(login)
    "/users/#{login}"
  end

  def authenticated_user_path
    '/user'
  end
end

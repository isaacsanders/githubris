module Githubris::API::User
  NOT_AUTHENTICATED_ERRORS = [
    Githubris::Error::RequiresAuthentication,
    Githubris::Error::BadCredentials,
    Githubris::Error::MaxNumberOfLoginAttemptExceeded
  ]

  def authenticated?
    get_authenticated_user
  rescue *NOT_AUTHENTICATED_ERRORS
    nil
  end

  def get_user(login)
    Githubris::User.new get_data_from(user_path(login))
  end

  def get_authenticated_user
    Githubris::User.new get_data_from(authenticated_user_path)
  end

  private
  def user_path(login)
    "/users/#{login}"
  end

  def authenticated_user_path
    '/user'
  end
end

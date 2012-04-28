require 'githubris/user'

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

  def patch_user(params)
    Githubris::User.new patch_data_to(authenticated_user_path, params)
  end

  def get_user_following(login)
    get_users_from(user_following_path(login))
  end

  def get_user_followers(login)
    get_users_from(user_followers_path(login))
  end

  def get_emails
    set_request_path emails_path
    data = load_json(dump_json(raw_get.parsed_response))
    raise_if_error(data)
    data
  end

  def put_follow_user(login)
    set_request_path(user_follows_path(login))
    raw_put(@target, @options.merge(:headers => {'Content-Length' => '0'}))
  end

  def delete_follow_user(login)
    set_request_path(user_follows_path(login))
    raw_delete
  end

  def get_user_following?(login)
    set_request_path(user_follows_path(login))
    case raw_get.code
    when 204
      true
    when 404
      false
    end
  end

  private

  def get_users_from(path)
    get_data_from(path).map do |user_data|
      Githubris::User.new user_data
    end
  end

  def user_follows_path(login)
    "/user/following/#{login}"
  end

  def user_following_path(login)
    "/users/#{login}/following"
  end

  def user_followers_path(login)
    "/users/#{login}/followers"
  end

  def emails_path
    '/user/emails'
  end

  def user_path(login)
    "/users/#{login}"
  end

  def authenticated_user_path
    '/user'
  end
end

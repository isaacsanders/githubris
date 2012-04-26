class Githubris::Error < StandardError; end
class Githubris::Error::RequiresAuthentication < Githubris::Error; end
class Githubris::Error::BadCredentials < Githubris::Error; end
class Githubris::Error::NotFound < Githubris::Error; end
class Githubris::Error::InvalidAttributes < Githubris::Error; end
class Githubris::Error::MaxNumberOfLoginAttemptExceeded < Githubris::Error; end

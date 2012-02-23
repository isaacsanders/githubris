class Githubris
  class User
    def self.build user_data
      if user_data.instance_of? Githubris::User
        return user_data
      else
        self.new
      end
    end
  end
end

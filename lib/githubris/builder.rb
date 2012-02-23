module Githubris
  class GistBuilder
    class << self
      def build data
        return data if data.instance_of? Githubris::Gist
        if data.instance_of? Array
          data.map do |gist_data|
            self.build gist_data
          end
        else
          data['user'] = Githubris::User.build data['user']
          Githubris::Gist.new data
        end
      end
    end
  end
end

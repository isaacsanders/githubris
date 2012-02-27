class Githubris
  class Builder
    def build data
      return data if data.instance_of? Githubris::Gist
      if data.instance_of? Array
        data.map do |gist_data|
          self.build gist_data
        end
      else
        build_gist data
      end
    end

    def build_gists(data)
      data.map do |gist|
        build_gist gist
      end
    end

    def build_gist(data)
      data[:user] = Githubris::User.build data.delete('user')
      data[:public] = data.delete('public')
      data[:description] = data.delete('description')
      data[:files] = data.delete('files').values
      data[:url] = URI.parse data.delete('url')
      data[:created_at] = DateTime.parse data.delete('created_at')
      data[:updated_at] = DateTime.parse data.delete('updated_at')
      tmp_arr = []
      data.delete('comments').times { tmp_arr << Githubris::Comment.new }
      data[:comments] = tmp_arr
      Githubris::Gist.new data
    end
  end
end

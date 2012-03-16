require 'githubris/uri'
require 'githubris/comment'
require 'githubris/gist'

class Githubris::Builder::Gist
  def build gist_data
    gist_data[:id] = Integer(gist_data.delete 'id' )
    gist_data[:user] = Githubris::Builder::User.build gist_data.delete('user')
    gist_data[:public] = gist_data.delete('public')
    gist_data[:description] = gist_data.delete('description')
    gist_data[:files] = gist_data.delete('files').values
    gist_data[:url] = URI.parse gist_data.delete('url')
    gist_data[:created_at] = DateTime.parse gist_data.delete('created_at')
    gist_data[:updated_at] = DateTime.parse gist_data.delete('updated_at')
    tmp_arr = []
    gist_data.delete('comments').times { tmp_arr << Githubris::Comment.new }
    gist_data[:comments] = tmp_arr
    Githubris::Gist.new gist_data
  end
end

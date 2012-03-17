class Githubris::Builder::Gist
  def build data
    gist_data = {}
    gist_data[:id] = Integer(data.delete('id'))
    gist_data[:public] = data.delete('public')
    gist_data[:description] = data.delete('description')
    gist_data[:files] = data.delete('files').values
    gist_data[:url] = URI.parse data.delete('url')
    gist_data[:created_at] = DateTime.parse data.delete('created_at')
    gist_data[:updated_at] = DateTime.parse data.delete('updated_at')
    tmp_arr = []
    data.delete('comments').times { tmp_arr << Githubris::Comment.new }
    gist_data[:comments] = tmp_arr
    Githubris::Gist.new gist_data
  end
end

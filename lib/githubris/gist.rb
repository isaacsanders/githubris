require 'date'

class Githubris::Gist < Githubris::Base
  autoload :File, 'githubris/gist/file'

  include Githubris::Publicity

  datetime_attribute :created_at, :updated_at
  accessible_attribute :description
  readable_attribute :id, :files
  uri_attribute :url

  def user
    @user ||= Githubris::User.new(@attributes[:user])
  end

  def reload
    swap_attributes @api.get_gist @attributes[:id]
  end

  def save
    swap_attributes @api.post_gist(
      :description => @attributes[:description],
      :public => @attributes[:public],
      :files => @attributes[:files]
    )
  end
end

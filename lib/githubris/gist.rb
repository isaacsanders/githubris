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

  def starred?
    @api.get_gist_starred_status(@attributes[:id])
  end

  def unstarred?
    !starred?
  end

  def reload
    swap_attributes @api.get_gist @attributes[:id]
  end

  def save
    if new?
      saved_attributes = @api.post_gist(saving_attributes)
    else
      saved_attributes = @api.patch_gist(@attributes[:id], saving_attributes)
    end
    swap_attributes saved_attributes
  end

  def saving_attributes
    {
      :description => @attributes[:description],
      :public => @attributes[:public],
      :files => @attributes[:files]
    }
  end

  def new?
    reload
  rescue Githubris::Error
    true
  else
    false
  end
end

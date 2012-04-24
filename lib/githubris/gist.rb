class Githubris::Gist < Githubris::Base
  include Githubris::Publicity

  datetime_attribute :created_at, :updated_at
  accessible_attribute :description
  readable_attribute :id, :files
  uri_attribute :url

  def user
    @user ||= Githubris::User.new(@attributes[:user])
  end

  def star!
    @api.put_gist_star(@attributes[:id])
  end

  def unstar!
    @api.delete_gist_star(@attributes[:id])
  end

  def starred?
    @api.get_gist_starred?(@attributes[:id])
  end

  def unstarred?
    !starred?
  end

  def delete!
    @api.delete_gist(@attributes[:id])
  end

  def history
    @attributes[:history].map do |gist_data|
      Githubris::Gist.new(gist_data)
    end
  end

  def reload
    if @attributes[:id]
      gist = @api.get_gist @attributes[:id]
    elsif @attributes[:url]
      gist = Githubris::Gist.new @api._get @attributes[:url]
    else
      raise Githubris::Error, 'Missing a unique identifier, such as an id or a url'
    end
    swap_attributes gist
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

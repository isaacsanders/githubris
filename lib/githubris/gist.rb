class Githubris::Gist < Githubris::Base
  datetime_attribute :created_at, :updated_at
  accessible_attribute :description, :files
  readable_attribute :id
  uri_attribute :url
  boolean_attribute :public

  def user
    @user ||= Githubris::User.new(@attributes[:user])
  end

  def star!
    @api.put_gist_star(id)
  end

  def unstar!
    @api.delete_gist_star(id)
  end

  def starred?
    @api.get_gist_starred?(id)
  end

  def unstarred?
    !starred?
  end

  def delete!
    @api.delete_gist(id)
  end

  def history
    @attributes[:history].map do |gist_data|
      Githubris::Gist.new(gist_data)
    end
  end

  def reload
    gist = @api.get_gist(id)
    swap_attributes! gist
  end

  def save
    if new?
      saved_attributes = @api.post_gist(saving_attributes)
    else
      saved_attributes = @api.patch_gist(id, saving_attributes)
    end
    swap_attributes! saved_attributes
  end

  def saving_attributes
    {
      :description => description,
      :public => public?,
      :files => files
    }
  end

  def new?
    id.nil?
  end
end

require 'date'

class Githubris::Gist
  autoload :File, 'githubris/gist/file'

  def initialize attributes={}
    @api = attributes.delete(:_api) || Githubris::API.new
    @attributes = attributes
    @attributes[:files] ||= {}
  end

  def id
    Integer(@attributes[:id])
  end

  def user
    user = Githubris::User.new @attributes[:user]
    user.reload
  end

  def created_at
    DateTime.parse @attributes[:created_at]
  end

  def updated_at
    DateTime.parse @attributes[:updated_at]
  end

  def description
    @attributes[:description]
  end

  def description=(description)
    @attributes[:description] = description
  end

  def files
    @attributes[:files]
  end

  def url
    URI.parse @attributes[:url]
  end

  def public?
    @attributes[:public]
  end

  def publicize
    @attributes[:public] = true
  end

  def privatize
    @attributes[:public] = false
  end

  def comments
    Array.new @attributes[:comments], Githubris::Comment.new
  end

  def ==(other)
    @attributes == other.instance_variable_get(:@attributes)
  end

  def reload
    swap_attributes @api.get_gist @attributes[:id]
  end

  def save
    input = {
      :description => @attributes[:description],
      :public => @attributes[:public],
      :files => @attributes[:files],
    }

    swap_attributes @api.post_gist(input)
  end

  def swap_attributes(other)
    instance_variable_set(:@attributes,
                          other.instance_variable_get(:@attributes))
    self
  end
end

class Githubris::Base
  extend Githubris::CustomAttributes

  def initialize attributes={}
    @api = attributes.delete(:_api) || Githubris::API.new
    @attributes = attributes
  end

  def ==(other)
    @attributes == other.instance_variable_get(:@attributes)
  end

  private

  def swap_attributes!(other)
    @attributes = other.instance_variable_get(:@attributes)
    self
  end
end

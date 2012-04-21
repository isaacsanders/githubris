module Githubris::CustomAttributes
  private

  def accessible_attribute(*attr_names)
    readable_attribute(*attr_names)
    writable_attribute(*attr_names)
  end

  def uri_attribute(*attr_names)
    attr_names.each do |name|
      define_method name do
        URI.parse @attributes[name]
      end
    end
  end

  def datetime_attribute(*attr_names)
    attr_names.each do |name|
      define_method name do
        DateTime.parse @attributes[name]
      end
    end
  end

  def readable_attribute(*attr_names)
    attr_names.each do |name|
      define_method name do
        @attributes[name]
      end
    end
  end

  def writable_attribute(*attr_names)
    attr_names.each do |name|
      define_method "#{name}=" do |new_value|
        @attributes[name] = new_value
      end
    end
  end
end

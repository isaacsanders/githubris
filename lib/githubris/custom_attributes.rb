module Githubris::CustomAttributes
  private

  def uri_attribute(*attr_names)
    attr_names.each do |name|
      define_method name do
        Addressable::URI.parse @attributes[name]
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

  def accessible_attribute(*attr_names)
    readable_attribute(*attr_names)
    writable_attribute(*attr_names)
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

  def boolean_attribute(*attr_names)
    predicate_attribute(*attr_names)
    positive_boolean_mutator_attribute(*attr_names)
    negative_boolean_mutator_attribute(*attr_names)
  end

  def predicate_attribute(*attr_names)
    attr_names.each do |name|
      define_method "#{name}?" do
        @attributes[name]
      end
    end
  end

  def positive_boolean_mutator_attribute(*attr_names)
    attr_names.each do |name|
      define_method "#{name}!" do
        @attributes[name] = true
      end
    end
  end

  def negative_boolean_mutator_attribute(*attr_names)
    attr_names.each do |name|
      define_method "not_#{name}!" do
        @attributes[name] = false
      end
    end
  end
end

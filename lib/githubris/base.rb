class Githubris::Base
  def initialize attributes={}
    @api = attributes.delete(:_api) || Githubris::API.new
    @attributes = attributes
  end

  def ==(other)
    @attributes == other.instance_variable_get(:@attributes)
  end

  def swap_attributes(other)
    instance_variable_set(:@attributes,
                          other.instance_variable_get(:@attributes))
    self
  end

  private

  class << self
    def accessible_attribute(*attr_names)
      attr_names.each do |name|
        class_eval accessible_methods_called(name)
      end
    end

    def accessible_methods_called(name)
      """
      def #{name}
        @attributes[:#{name}]
      end

      def #{name}=(#{name})
        @attributes[:#{name}] = #{name}
      end
      """
    end

    def uri_attribute(*attr_names)
      attr_names.each do |name|
        class_eval uri_method_called(name)
      end
    end

    def uri_method_called(name)
      """
      def #{name}
        URI.parse @attributes[:#{name}]
      end
      """
    end

    def datetime_attribute(*attr_names)
      attr_names.each do |name|
        class_eval datetime_method_called(name)
      end
    end

    def datetime_method_called(name)
      """
      def #{name}
        DateTime.parse @attributes[:#{name}]
      end
      """
    end

    def readable_attribute(*attr_names)
      attr_names.each do |name|
        class_eval readable_method_called(name)
      end
    end

    def readable_method_called(name)
      """
      def #{name}
        @attributes[:#{name}]
      end
      """
    end
  end
end
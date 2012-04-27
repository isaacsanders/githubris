require 'spec_helper'

describe Githubris::CustomAttributes do
  let(:attributed_class) do
    klass = Class.new
    klass.class_eval do
      extend Githubris::CustomAttributes

      def initialize(attributes)
        @attributes = attributes
      end
    end
    klass
  end

  describe '#uri_attribute' do
    it 'defines an instance method that returns a URI object' do
      attributed_class.class_eval do
        uri_attribute :foo
      end

      object = attributed_class.new(:foo => 'http://google.com')
      object.foo.should be_instance_of Addressable::URI
    end
  end

  describe '#accessible_attribute' do
    it 'defines an instance method that returns the attribute named by the method' do
      attributed_class.class_eval do
        accessible_attribute :foo
      end

      lots_of_text = 'this is a lot of text'
      object = attributed_class.new(:foo => lots_of_text)

      lambda do
        object.foo == lots_of_text
        object.foo = 'Not a ton of text'
      end.should_not raise_error

      object.foo.should == 'Not a ton of text'
    end
  end

  describe '#datetime_attribute' do
    it 'defines an instance method that returns a DateTime object' do
      attributed_class.class_eval do
        datetime_attribute :foo
      end

      object = attributed_class.new(:foo => '3:00PM 1/3/1994')
      object.foo.should be_kind_of DateTime
    end
  end

  describe '#readable_attribute' do
    it 'defines a getter for the attributes passed in' do
      attributed_class.class_eval do
        readable_attribute :foo, :bar, :baz
      end

      object = attributed_class.new(:foo => 'asdf',
                              :bar => 'fdsa',
                              :baz => 'qwerty')

      lambda do
        object.foo.should == 'asdf'
        object.bar.should == 'fdsa'
        object.baz.should == 'qwerty'
      end.should_not raise_error
    end
  end

  describe '#boolean_attribute' do
    it 'defines a predicate' do
      attributed_class.class_eval do
        boolean_attribute :foo
      end

      object = attributed_class.new(:foo => true)

      lambda do
        object.should be_foo
      end.should_not raise_error
    end

    it 'defines mutators' do
      attributed_class.class_eval do
        boolean_attribute :foo
      end

      object = attributed_class.new(:foo => true)

      lambda do
        object.foo!
        object.should be_foo
        object.not_foo!
        object.should_not be_foo
      end.should_not raise_error
    end
  end
end

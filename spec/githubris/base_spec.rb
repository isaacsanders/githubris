require 'spec_helper'

describe Githubris::Base do
  it 'has an attributes hash' do
    subject.instance_variable_get(:@attributes).should be_instance_of Hash
  end

  describe '#==' do
    it 'matches based on attributes' do
      object1 = described_class.new({:foo => 'bar'})
      object2 = described_class.new({:foo => 'bar'})
      object1.should == object2
    end
  end

  context 'defining attributes' do
    let(:mock_class) { Class.new(described_class) }

    describe '::uri_attribute' do
      it 'defines an instance method that returns a URI object' do
        mock_class.class_eval do
          uri_attribute :foo
        end

        object = mock_class.new(:foo => 'http://google.com')
        object.foo.should be_instance_of Addressable::URI
      end
    end

    describe '::accessible_attribute' do
      it 'defines an instance method that returns the attribute named by the method' do
        mock_class.class_eval do
          accessible_attribute :foo
        end

        lots_of_text = 'this is a lot of text'
        object = mock_class.new(:foo => lots_of_text)

        lambda do
          object.foo == lots_of_text
          object.foo = 'Not a ton of text'
        end.should_not raise_error

        object.foo.should == 'Not a ton of text'
      end
    end

    describe '::datetime_attribute' do
      it 'defines an instance method that returns a DateTime object' do
        mock_class.class_eval do
          datetime_attribute :foo
        end

        object = mock_class.new(:foo => '3:00PM 1/3/1994')
        object.foo.should be_kind_of DateTime
      end
    end

    describe '::readable_attribute' do
      it 'defines a getter for the attributes passed in' do
        mock_class.class_eval do
          readable_attribute :foo, :bar, :baz
        end

        object = mock_class.new(:foo => 'asdf',
                                :bar => 'fdsa',
                                :baz => 'qwerty')

        lambda do
          object.foo.should == 'asdf'
          object.bar.should == 'fdsa'
          object.baz.should == 'qwerty'
        end.should_not raise_error
      end
    end
  end
end

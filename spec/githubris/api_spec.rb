require 'spec_helper'

describe Githubris::API do
  describe '#get_public_gists' do
    it 'returns an array of gists' do
      subject.get_public_gists.should be_instance_of Array
      subject.get_public_gists.each do |gist|
        gist.should be_instance_of Githubris::Gist
      end
    end

    it 'accepts an options hash' do
      lambda do
        subject.get_public_gists({foo: 'bar'})
      end.should_not raise_error
    end

    context 'given a quantity option' do
      it 'returns an array of gists with that quantity' do
        subject.get_public_gists(quantity: 10).should have(10).items
        subject.get_public_gists(quantity: 30).should have(30).items
        subject.get_public_gists(quantity: 31).should have(31).items
        subject.get_public_gists(quantity: 45).should have(45).items
        subject.get_public_gists(quantity: 61).should have(61).items
      end
    end
  end
end

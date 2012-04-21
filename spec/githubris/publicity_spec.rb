
describe Githubris::Publicity do
  subject do
    Githubris::Base.new(:public => true).extend Githubris::Publicity
  end

  it                { should be_public }

  describe '#publicize!' do
    it 'makes the gist public' do
      subject.publicize!
      subject.should be_public
    end
  end

  describe '#privatize!' do
    it 'makes the gist private' do
      subject.privatize!
      subject.should_not be_public
    end
  end
end

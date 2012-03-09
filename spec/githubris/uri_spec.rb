require 'spec_helper'

describe Githubris::URI do
  describe '#==' do
    it 'checks against the parsed URI' do
      core_uri = URI.parse 'google.com'
      ghr_uri = Githubris::URI.parse 'google.com'
      ghr_uri.should == core_uri
    end
  end
end

require 'multi_json'
require 'json/pure'

module Githubris::API::JSON
  MultiJson.use :json_pure

  private

  def load_json(json)
    MultiJson.load(json, :symbolize_keys => true)
  end

  def dump_json(json)
    MultiJson.dump(json)
  end
end

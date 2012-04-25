require 'multi_json'
require 'yajl'

module Githubris::API::JSON
  MultiJson.use :yajl

  private

  def load_json(json)
    MultiJson.load(json, :symbolize_keys => true)
  end

  def dump_json(json)
    MultiJson.dump(json)
  end
end

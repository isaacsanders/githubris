# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "githubris/version"

Gem::Specification.new do |s|
  s.name        = "githubris"
  s.version     = Githubris::VERSION
  s.authors     = ["Isaac Sanders"]
  s.email       = ["isaac@isaacbfsanders.com"]
  s.homepage    = "http://isaacbfsanders.com/githubris"
  s.summary     = %q{Githubris is meant to make Github API interaction a breeze.}
  s.description = %q{Githubris is meant to make Github API interaction a breeze.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('httparty')
  s.add_dependency('faraday')
  s.add_dependency('multi_json')
  s.add_dependency('json_pure')
  s.add_dependency('addressable')
end

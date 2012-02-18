# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "githubris/version"

Gem::Specification.new do |s|
  s.name        = "githubris"
  s.version     = Githubris::VERSION
  s.authors     = ["Isaac Sanders"]
  s.email       = ["isaac@isaacbfsanders.com"]
  s.homepage    = "isaacbfsanders.com/githubris"
  s.summary     = %q{Githubris is meant to make Github API interaction a breeze.}
  s.description = %q{Githubris is meant to make Github API interaction a breeze.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "cucumber", "~> 1.1.0"
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simplecov-phabricator/version"

Gem::Specification.new do |s|
  s.name        = "simplecov-phabricator"
  s.version     = SimpleCov::Formatter::PhabricatorFormatter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Omar Skalli"]
  s.email       = ["chetane@gmail.com"]
  s.homepage    = SimpleCov::Formatter::PhabricatorFormatter::UPSTREAM_URL
  s.summary     = %q{A Simplecov Phabricator Formatter}
  s.description = %q{A Simplevoc Formatter compatible with Phabricator's code review format.}
  s.license = 'MIT'
  s.extra_rdoc_files = [
      "README.rdoc"
    ]

  s.rubyforge_project = "simplecov-phabricator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
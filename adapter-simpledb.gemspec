# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adapter/simpledb/version"

Gem::Specification.new do |s|
  s.name        = "adapter-simpledb"
  s.version     = Adapter::SimpleDB::VERSION
  s.authors     = ["Daniel Morrison"]
  s.email       = ["daniel@collectiveidea.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "adapter-simpledb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'adapter', '~>0.5.1'
  s.add_dependency 'fog',     '~>1.0.0'
end

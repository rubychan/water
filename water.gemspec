# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "water"
  s.version     = '0.2.3'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kornelius Kalnbach"]
  s.email       = ["murphy@rubychan.de"]
  s.homepage    = "http://water.rubychan.de"
  s.summary     = "diff viewer with code highlighting"
  s.description = "The diff washing machine. See your code changes clearly."
  
  s.add_dependency "coderay", '= 1.0.0.788.pre'
  s.add_dependency "launchy", '~> 0.4.0'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end

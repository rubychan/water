# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "water"
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kornelius Kalnbach"]
  s.email       = ["murphy@rubychan.de"]
  s.homepage    = "http://water.rubychan.de"
  s.summary     = "The diff washing machine. See your code changes clearly."
  s.description = <<-DESCRIPTION
Water takes a unified diff as its input and opens a browser window
with a nicely formatted display of it. It uses CodeRay to highlight the code
inside of the diff.
  DESCRIPTION
  
  # s.rubyforge_project = "water"
  
  s.add_dependency "coderay", '= 1.0.0.738.pre'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end

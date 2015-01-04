# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pegi/version'

Gem::Specification.new do |spec|
  spec.name          = "pegi"
  spec.version       = Pegi::VERSION
  spec.authors       = ["Victor Borja"]
  spec.email         = ["vborja@apache.org"]
  spec.summary       = %q{Minimalist PEG as Ruby DSL}
  spec.description   = %q{A minimalist parser expression grammar in pure ruby dsl}
  spec.homepage      = "http://github.com/vic/pegi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end

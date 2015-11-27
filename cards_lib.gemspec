# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cards_lib/version'

Gem::Specification.new do |spec|
  spec.name          = "cards_lib"
  spec.version       = CardsLib::VERSION
  spec.authors       = ["Daniel P. Clark"]
  spec.email         = ["6ftdan@gmail.com"]

  spec.summary       = %q{OO Card Game Library}
  spec.description   = %q{Card Game Library.  Testable and Object Oriented.}
  spec.homepage      = "http://github.com/danielpclark/CardsLib"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.1'

  spec.add_development_dependency "bundler", "~> 1.10.6"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "color_pound_spec_reporter", "~> 0.0.5"
  spec.add_development_dependency "minitest", "~> 5.8.1"
  spec.add_development_dependency "minitest-reporters", "~> 1.1.4"
end

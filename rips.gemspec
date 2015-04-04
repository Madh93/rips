# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rips/version'

Gem::Specification.new do |spec|
  spec.name          = "rips"
  spec.version       = Rips::VERSION
  spec.authors       = ["Madh93"]
  spec.email         = ["michelangelo93@gmail.com"]
  spec.summary       = %q{Simple assembler for a simple 16-bit CPU.}
  spec.description   = %q{Simple assembler written in Ruby for a simple 16-bit CPU written in Verilog.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = "rips"
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dyna_form/version'

Gem::Specification.new do |spec|
  spec.name          = "dyna_form"
  spec.version       = DynaForm::VERSION
  spec.authors       = ["Willux"]
  spec.email         = ["zaikaus1@gmail.com"]
  spec.summary       = %q{A gem used to help delegate form fields to their respective models.}
  spec.description   = %q{We want to avoid nested forms while creating a form based on some object. This will help keep the forms clean while easily delegating each field into their models.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
end

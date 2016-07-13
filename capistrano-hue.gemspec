# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/hue/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-hue"
  spec.version       = Capistrano::Hue::VERSION
  spec.authors       = ["Kristopher Bredemeier"]
  spec.email         = ["kb@i22.de"]

  spec.summary       = %q{Capistrano tasks for using Philips Hue lights as deployment indicator.}
  spec.description   = %q{Capistrano tasks for using Philips Hue lights as deployment indicator.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end

# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coub_api/version'

Gem::Specification.new do |spec|
  spec.name          = "coub_api"
  spec.version       = CoubApi::VERSION
  spec.authors       = ["Peter Savichev (proton)"]
  spec.email         = ["psavichev@gmail.com"]
  spec.description   = "Ruby wrapper for Coub API."
  spec.summary       = "Ruby wrapper for Coub API."
  spec.homepage      = "https://github.com/proton/coub_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "faraday", "~> 0.8"
  spec.add_runtime_dependency "multi_json", "~> 1.3"
  spec.add_runtime_dependency "hashie"
end

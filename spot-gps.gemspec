# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spot-gps/version'

Gem::Specification.new do |spec|
  spec.name          = 'spot-gps'
  spec.version       = SPOT::VERSION
  spec.author        = 'Grey Baker'
  spec.email         = 'greysteil@gmail.com'
  spec.homepage      = 'https://github.com/greysteil/spot-gps'
  spec.summary       = 'A wrapper for the SPOT API'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.metadata = {
    'home' => 'https://github.com/greysteil/spot-gps',
    'code' => 'https://github.com/greysteil/spot-gps',
    'bugs' => 'https://github.com/greysteil/spot-gps/issues'
  }

  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec-its', '~> 1.0'

  spec.add_dependency 'faraday', ['>= 0.8.9', '< 0.10']
end

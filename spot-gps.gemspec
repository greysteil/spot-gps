# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spot-gps/version'

Gem::Specification.new do |spec|
  spec.name          = 'spot-gps'
  spec.version       = SPOT::VERSION
  spec.authors       = ['Grey Baker']
  spec.email         = ['greysteil@gmail.com']
  spec.summary       = %q{A wrapper for the SPOT API}
  spec.description   = %q{A wrapper for the SPOT API}
  spec.homepage      = 'http://github.com/greysteil/spot-gps'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec-its'

  spec.add_dependency 'faraday', ['>= 0.8.9', '< 0.10']
end

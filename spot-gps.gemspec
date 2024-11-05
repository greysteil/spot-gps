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
    'homepage_uri' => 'https://github.com/greysteil/spot-gps',
    'source_code_uri' => 'https://github.com/greysteil/spot-gps',
    'bug_tracker_uri' => 'https://github.com/greysteil/spot-gps/issues',
    'changelog_uri' => 'https://github.com/greysteil/spot-gps/blob/master/CHANGELOG.md'
  }

  spec.add_development_dependency 'webmock', ">= 1.22", "< 4.0"
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec-its', '~> 2.0'

  spec.add_dependency 'faraday', ">= 2.0.0", "< 3.0.0"
  spec.add_dependency 'faraday-net_http', ">= 2.0.0", "< 4.0.0"
end

# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'groupme/version'

Gem::Specification.new do |spec|
  spec.platform     = Gem::Platform::RUBY
  spec.name         = 'groupme-api'
  spec.version      = GroupMe::VERSION
  spec.summary      = 'A Ruby wrapper for GroupMe REST API (v3)'

  spec.author       = 'Kinnell Shah'
  spec.email        = 'kinnell@gmail.com'
  spec.homepage     = 'https://github.com/kinnell/groupme-ruby-gem'

  spec.files        = `git ls-files`.split("\n")
  spec.require_path = 'lib'

  spec.add_dependency 'httpclient', '~> 2.8'

  spec.add_development_dependency 'bundler',          '~> 1.16'
  spec.add_development_dependency 'coveralls',        '~> 0.8'
  spec.add_development_dependency 'guard-rspec',      '~> 4.7'
  spec.add_development_dependency 'rake',             '~> 10.0'
  spec.add_development_dependency 'rspec',            '~> 3.8'
  spec.add_development_dependency 'simplecov',        '~> 0.15'
  spec.add_development_dependency 'vcr',              '~> 4.0'
  spec.add_development_dependency 'webmock',          '~> 3.4'
end

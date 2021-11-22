# frozen_string_literal: true

require_relative 'lib/groupme/version'

Gem::Specification.new do |spec|
  spec.name         = 'groupme-api'
  spec.version      = GroupMe::VERSION
  spec.platform     = Gem::Platform::RUBY
  spec.authors      = ['Kinnell Shah']
  spec.email        = ['kinnell@gmail.com']

  spec.summary      = 'GroupMe'
  spec.description  = 'A Ruby wrapper for GroupMe REST API (v3)'
  spec.homepage     = 'https://github.com/kinnell/groupme-ruby-gem'
  spec.license      = 'MIT'

  spec.files = Dir['lib/**/*', 'Gemfile', '*.md']
  spec.require_path = 'lib'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')
  spec.required_rubygems_version = Gem::Requirement.new('>= 2.0')

  spec.add_dependency 'httpclient', '~> 2.8'

  spec.add_development_dependency 'bundler',        '~> 2.1'
  spec.add_development_dependency 'byebug',         '~> 11.0'
  spec.add_development_dependency 'coveralls',      '~> 0.8'
  spec.add_development_dependency 'guard',          '~> 2.16'
  spec.add_development_dependency 'guard-rspec',    '~> 4.7'
  spec.add_development_dependency 'guard-rubocop',  '~> 1.0'
  spec.add_development_dependency 'rake',           '~> 13.0'
  spec.add_development_dependency 'rspec',          '~> 3.9'
  spec.add_development_dependency 'simplecov',      '~> 0.16'
  spec.add_development_dependency 'vcr',            '~> 5.0'
  spec.add_development_dependency 'webmock',        '~> 3.8'
end

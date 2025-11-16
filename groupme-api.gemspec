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

  spec.metadata['github_repo']           = 'ssh://github.com/kinnell/groupme-ruby-gem'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir[
    'lib/**/*',
    'Gemfile',
    '*.md'
  ]

  spec.require_paths = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.0')
  spec.required_rubygems_version = Gem::Requirement.new('>= 3.0')

  spec.add_dependency 'httpclient', '~> 2.8'
end

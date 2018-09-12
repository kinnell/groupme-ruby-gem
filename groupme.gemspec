# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'groupme/version'

Gem::Specification.new do |spec|
  spec.platform     = Gem::Platform::RUBY
  spec.name         = 'groupme'
  spec.version      = GroupMe::VERSION
  spec.summary      = 'A Ruby wrapper for GroupMe REST API (v3)'

  spec.author       = 'Kinnell Shah'
  spec.email        = 'kinnell@gmail.com'
  spec.homepage     = 'https://github.com/kinnell/groupme-ruby-gem'

  spec.files        = `git ls-files`.split("\n")
  spec.require_path = 'lib'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
end

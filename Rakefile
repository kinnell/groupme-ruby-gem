# frozen_string_literal: true

require 'bundler/gem_tasks'

task default: :test

desc 'Run tests'
task :test do
  exec 'bundle exec rspec'
end

desc 'Run ruby linter'
task :lint do
  exec 'bundle exec rubocop'
end

desc 'Enter Guard session'
task :guard do
  exec 'bundle exec guard'
end

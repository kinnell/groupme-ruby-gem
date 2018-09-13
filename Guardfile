# frozen_string_literal: true

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^spec/fixtures/(.+)\.json$}) { 'spec' }
  watch(%r{^spec/support/(.+)$}) { 'spec' }
end

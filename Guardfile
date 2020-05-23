# frozen_string_literal: true

group :development, halt_on_fail: true do
  clearing :on

  guard :rspec, cmd: 'bundle exec rspec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch('spec/spec_helper.rb') { 'spec' }
    watch(%r{^spec/support/(.+)$}) { 'spec' }

    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  end

  guard :rubocop, all_on_start: false, cli: '--format simple' do
    watch(%r{^.+\.rb$})
    watch('.rubocop.yml')
  end
end

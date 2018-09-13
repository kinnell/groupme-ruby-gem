# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
require 'webmock'

SimpleCov.start
Coveralls.wear!
WebMock.enable!

require 'bundler/setup'
require 'groupme'

RSpec.configure do |config|
  include WebMock::API

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

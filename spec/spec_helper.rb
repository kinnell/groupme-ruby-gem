# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
require 'webmock'
require 'vcr'

SimpleCov.start
Coveralls.wear!
WebMock.enable!

require 'bundler/setup'
require 'groupme'
require 'securerandom'

RSpec.configure do |config|
  # include WebMock::API
  # WebMock.allow_net_connect!

  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data('<ACCESS_TOKEN>') { ACCESS_TOKEN }
end

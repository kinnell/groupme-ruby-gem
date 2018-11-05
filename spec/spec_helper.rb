# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
require 'vcr'

SimpleCov.start
Coveralls.wear!

require 'bundler/setup'
require 'groupme'
require 'securerandom'
require 'support/webmock'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
end

VCR.configure do |config|
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/fixtures'
  config.default_cassette_options = { record: :new_episodes }
  config.filter_sensitive_data('ACCESS_TOKEN') { ACCESS_TOKEN }
end

# TEST_ACCOUNT_ACCESS_TOKEN = ''
ACCESS_TOKEN = defined?(TEST_ACCOUNT_ACCESS_TOKEN) ? TEST_ACCOUNT_ACCESS_TOKEN : SecureRandom.base64(30).tr('+', '0')

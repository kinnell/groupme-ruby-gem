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
  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data('<ACCESS_TOKEN>') { GroupMe.configuration.access_token || '' }
end

RSpec.shared_context :groupme_configured_with_access_token do
  let(:fake_access_token) { SecureRandom.base64(30) }

  before do
    GroupMe.configure do |config|
      config.access_token = defined?(TEST_ACCOUNT_ACCESS_TOKEN) ? TEST_ACCOUNT_ACCESS_TOKEN : fake_access_token
    end
  end
end

# Set Test Account's Access Token to generate fixtures (Not needed if fixtures generated)
# TEST_ACCOUNT_ACCESS_TOKEN = ''

# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
require 'vcr'

SimpleCov.start
Coveralls.wear!

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
  config.hook_into :webmock
  config.cassette_library_dir = 'spec/fixtures'
  config.default_cassette_options = { record: :new_episodes }
  config.filter_sensitive_data('ACCESS_TOKEN') { GroupMe.configuration.access_token }
end

RSpec.shared_context :groupme_configured_with_access_token do
  before do
    GroupMe.configure do |config|
      config.access_token = defined?(TEST_ACCOUNT_ACCESS_TOKEN) ? TEST_ACCOUNT_ACCESS_TOKEN : 'ACCESS_TOKEN'
    end
  end
end

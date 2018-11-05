# frozen_string_literal: true

require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

require 'bundler/setup'
require 'groupme'
require 'securerandom'
require 'support/vcr'
require 'support/webmock'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
end
# TEST_ACCOUNT_ACCESS_TOKEN = ''
ACCESS_TOKEN = defined?(TEST_ACCOUNT_ACCESS_TOKEN) ? TEST_ACCOUNT_ACCESS_TOKEN : SecureRandom.base64(30).tr('+', '0')

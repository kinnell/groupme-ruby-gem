# frozen_string_literal: true

require 'securerandom'

# TEST_ACCOUNT_ACCESS_TOKEN = ''
ACCESS_TOKEN = defined?(TEST_ACCOUNT_ACCESS_TOKEN) ? TEST_ACCOUNT_ACCESS_TOKEN : SecureRandom.base64(30).tr('+', '0')

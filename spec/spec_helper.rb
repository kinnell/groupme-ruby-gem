# frozen_string_literal: true

require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

require 'groupme'

require 'support/groupme'
require 'support/vcr'
require 'support/webmock'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
end

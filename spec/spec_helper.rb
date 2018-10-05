# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
require 'webmock'

SimpleCov.start
Coveralls.wear!
WebMock.enable!

require 'bundler/setup'
require 'groupme'
require 'support/fake_groupme'
require 'securerandom'

RSpec.configure do |config|
  include WebMock::API

  config.filter_run_when_matching :focus

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:any, /api.groupme.com/).to_rack(FakeGroupMe)
  end
end

# frozen_string_literal: true

require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

require 'groupme'

SPEC_PATH = Pathname.getwd.join('spec').freeze
SPEC_PATH.glob('support/**/*.rb').each { |file| require file }

RSpec.configure do |config|
  config.filter_run_when_matching :focus
end

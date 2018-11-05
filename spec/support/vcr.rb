# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/fixtures'
  config.default_cassette_options = { record: :new_episodes }
  config.filter_sensitive_data('ACCESS_TOKEN') { ACCESS_TOKEN }
end

# frozen_string_literal: true

require 'http'

require 'groupme/configuration'
require 'groupme/version'

module GroupMe
  API_BASE_URL = 'https://api.groupme.com/v3/'
  CLIENT = HTTPClient.new(base_url: API_BASE_URL, default_header: { 'Content-Type' => 'application/json' })

  class << self
    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.reset!
    @configuration = Configuration.new
  end
end

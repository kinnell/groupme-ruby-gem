# frozen_string_literal: true

require 'http'

require 'groupme/configuration'
require 'groupme/request'
require 'groupme/version'

module GroupMe
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

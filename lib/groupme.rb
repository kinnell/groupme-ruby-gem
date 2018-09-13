# frozen_string_literal: true

require 'groupme/configuration'
require 'groupme/version'

module GroupMe
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.reset!
    @configuration = Configuration.new
  end
end

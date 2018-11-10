# frozen_string_literal: true

module GroupMe
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.reset!
    @configuration = Configuration.new
  end

  class Configuration
    attr_accessor :access_token
  end
end

# frozen_string_literal: true

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

  class Configuration
    attr_accessor :access_token
  end
end

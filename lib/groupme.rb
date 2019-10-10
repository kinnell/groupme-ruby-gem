# frozen_string_literal: true

require 'httpclient'
require 'json'

require 'groupme/client'
require 'groupme/configuration'
require 'groupme/errors'
require 'groupme/group'
require 'groupme/version'

module GroupMe
  def self.reset!
    @configuration = Configuration.new
  end
end

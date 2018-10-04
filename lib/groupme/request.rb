# frozen_string_literal: true

module GroupMe
  class Request
    API_BASE_URI = 'https://api.groupme.com/v3'
    ACCEPTABLE_METHODS = [:get, :post, :delete]

    attr_reader :method, :path, :opts

    def initialize(method = :get, path = '', opts = {})
      raise UnacceptableRequestMethodError unless ACCEPTABLE_METHODS.include?(method)
      @method = method
      @path   = path
      @opts   = opts
    end

    def full_uri
      "#{API_BASE_URI}/#{@path}"
    end

    def token
      @token = @opts[:token] || GroupMe.configuration.access_token
    end
  end

  class UnacceptableRequestMethodError < StandardError; end
end

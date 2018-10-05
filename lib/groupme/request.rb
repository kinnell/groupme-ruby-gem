# frozen_string_literal: true

module GroupMe
  class Request
    API_BASE_URI = 'https://api.groupme.com/v3'
    ACCEPTABLE_METHODS = %i[get post delete].freeze

    attr_reader :method, :path, :opts

    def initialize(method = :get, path = '', opts = {})
      raise UnacceptableRequestMethodError unless ACCEPTABLE_METHODS.include?(method)

      @method = method
      @path   = path
      @opts   = opts
    end

    def send!
      response = HTTP.request(@method, full_uri, params: full_opts)
      Response.new(response)
    end

    def full_uri
      "#{API_BASE_URI}/#{@path}"
    end

    def full_opts
      { token: token }.merge(@opts)
    end

    def token
      @token = @opts[:token] || GroupMe.configuration.access_token
    end
  end

  class UnacceptableRequestMethodError < StandardError; end
end

# frozen_string_literal: true

module GroupMe
  class Client
    API_BASE_URL = 'https://api.groupme.com/v3/'

    def initialize(access_token:)
      @access_token = access_token
      @client = HTTPClient.new do |config|
        config.base_url = API_BASE_URL
        config.default_header = { 'Content-Type': 'application/json' }
      end
    end

    def request(method, path, query: {}, body: {})
      @client.request(method, path, { token: @access_token }.merge(query), body)
    end
  end
end

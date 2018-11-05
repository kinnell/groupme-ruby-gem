# frozen_string_literal: true

module GroupMe
  class Client
    API_BASE_URL = 'https://api.groupme.com/v3/'
    API_DEFAULT_HEADER = { 'Content-Type': 'application/json' }.freeze

    def initialize(access_token:)
      @access_token = access_token
      @client = HTTPClient.new(base_url: API_BASE_URL, default_header: API_DEFAULT_HEADER)
    end

    def request(method, path, query: {}, body: {})
      response = @client.request(method, path, { token: @access_token }.merge(query), body)
      JSON.parse(response.body, symbolize_names: true).fetch(:response) if response.ok?
    end

    def get(path, query = {})
      request(:get, path, query: query)
    end

    def post(path, body = {})
      request(:post, path, body: body)
    end

    def delete(path, query = {})
      request(:delete, path, query: query)
    end
  end
end

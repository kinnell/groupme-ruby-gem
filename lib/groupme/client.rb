# frozen_string_literal: true

module GroupMe
  class Client
    API_BASE_URL = 'https://api.groupme.com/v3/'
    API_DEFAULT_HEADER = { 'Content-Type': 'application/json' }.freeze

    attr_accessor :access_token

    def initialize(args = {})
      @access_token = args[:access_token] || GroupMe.configuration.access_token
      @client = HTTPClient.new(base_url: API_BASE_URL, default_header: API_DEFAULT_HEADER)
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

    def request(method, path, query: {}, body: nil)
      response = @client.request(method, path, { token: @access_token }.merge(query), body&.to_json)
      [parse_response_body(response), response.status]
    end

    private

    def parse_response_body(response)
      return response.reason unless response.ok?
      return if blank?(response.body)

      JSON.parse(response.body, symbolize_names: true).fetch(:response)
    end

    def blank?(string)
      string =~ %r{\A[[:space:]]*\z}
    end
  end

  def self.client=(client)
    @client = client
  end

  def self.client
    @client ||= Client.new
  end
end
